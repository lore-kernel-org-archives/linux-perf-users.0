Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF8263C71;
	Mon, 28 Apr 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849601; cv=none; b=r3hXDzksbuXEnmmSTjW5YibBAlhMKAjepxGh06GHU7YS9zJN6/dhIvEaW7u9H4NhOnmW4VaVK27/eVWuGMqFR6Y4kpomqMIu9v2LFsExpxd6xqUToiU4oOgoLmN6PC2h3ucfkaaEH904ZsJOtjX8rrZe3bmr6rmzb3QwVbPKsfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849601; c=relaxed/simple;
	bh=AJ7996YeGnN3pDpQTHfdu0iEi13QtLhDnx96lZGurbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCmPFk7mrhSHgi99PDUuBaDsSXpgkO2Px3P2nqBmVQHL2vCtT3IRjdpUTyNcbhuy3aHR4n+jslwdeduOw1WLfjDSqfvr4H8gfM7igGsXLIzI7FFuAXhWNQgRNnsXHQMs9/RmBRQRXh9CXKlyYFxGdKPdzp3oKFAY0a34KXkY4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P44KaIKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P44KaIKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46917C4CEE4;
	Mon, 28 Apr 2025 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745849600;
	bh=AJ7996YeGnN3pDpQTHfdu0iEi13QtLhDnx96lZGurbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P44KaIKvprhRx0fbq1ZkL3uFBu9tEGNrtNekHu8H4Zt5gcI6c1NYx8BAf1hBgDxjC
	 ifgds64BNZbKMqc6XzPSStrHJaqFsvhUfwHatHfQRoetnuBW9PZq2aF2lphpJyjTrA
	 MzPX7ydiLNc6aTU6yjYlFUnwV3Sv6KwdlmkRBgV8GHO02o3HsLbMhsAbgtubX0yy2j
	 fCkVAcEw+IFYgt0hw8/3wlUn5yptxTUoI+wXolbNcTseodYqn0WlBGX4qoSG67KVDV
	 l9xi8ZFoUGeaaEtqDaWzYwozoO58wmUF4V6FA/79WC3RXkKVG+1yHKjoSzGCVxM+3N
	 yassLV0XiZTSw==
Date: Mon, 28 Apr 2025 09:13:18 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
 with vCPU's value.
Message-ID: <aA-M_kT6qr5xM7u4@do-x1carbon>
References: <20250426001355.1026530-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426001355.1026530-1-seanjc@google.com>

On Fri, Apr 25, 2025 at 05:13:55PM -0700, Sean Christopherson wrote:
> When generating the MSR_IA32_PEBS_ENABLE value that will be loaded on
> VM-Entry to a KVM guest, mask the value with the vCPU's desired PEBS_ENABLE
> value.  Consulting only the host kernel's host vs. guest masks results in
> running the guest with PEBS enabled even when the guest doesn't want to use
> PEBS.  Because KVM uses perf events to proxy the guest virtual PMU, simply
> looking at exclude_host can't differentiate between events created by host
> userspace, and events created by KVM on behalf of the guest.
> 
> Running the guest with PEBS unexpectedly enabled typically manifests as
> crashes due to a near-infinite stream of #PFs.  E.g. if the guest hasn't
> written MSR_IA32_DS_AREA, the CPU will hit page faults on address '0' when
> trying to record PEBS events.
> 
> The issue is most easily reproduced by running `perf kvm top` from before
> commit 7b100989b4f6 ("perf evlist: Remove __evlist__add_default") (after
> which, `perf kvm top` effectively stopped using PEBS).	The userspace side
> of perf creates a guest-only PEBS event, which intel_guest_get_msrs()
> misconstrues a guest-*owned* PEBS event.
> 
> Arguably, this is a userspace bug, as enabling PEBS on guest-only events
> simply cannot work, and userspace can kill VMs in many other ways (there
> is no danger to the host).  However, even if this is considered to be bad
> userspace behavior, there's zero downside to perf/KVM restricting PEBS to
> guest-owned events.
> 
> Note, commit 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily
> in two rare situations") fixed the case where host userspace is profiling
> KVM *and* userspace, but missed the case where userspace is profiling only
> KVM.
> 
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/all/Z_VUswFkWiTYI0eD@do-x1carbon
> Cc: stable@vger.kernel.org
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Tested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
