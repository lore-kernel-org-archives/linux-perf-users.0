Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2101FDE12;
	Fri, 18 Apr 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965152; cv=none; b=mXLbimFQq5I6t8hL+klAiApBVJg2XKTVCdYx98bb9La4fRrGgR2l9gwZfMw/POOq4mkLp3yVYXCF6TRW68T2FOg6N/5UBc9Gg0Ovqab+YelbAukHXhF4oJpykwvsrLFNHboXYOwJTfMRGhWl6O/LX+Mx9Ns7Xp5GKZYx2o8j8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965152; c=relaxed/simple;
	bh=DBcmfGPlOYxSIWeCzpc6ORK7sl/z26lxe+TcEDYk5yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQj8ukfBIS5EeitCpXb9Hfmiat1JBa8yiDQvGBYdVDSeBpbdDpL77A7E1xDVfpRg9PHqLamLNd9BUOn6senrBxW9IVFsoJY9iR6uQB5X/IHY1EK7IaCs0fKkOFiO9cg4ZSx1fJCtX/vZ2xkkU9OBLFZkMIjBdP8mS+3MXZO/Fuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgeUr496; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgeUr496"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED6C4CEE2;
	Fri, 18 Apr 2025 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744965152;
	bh=DBcmfGPlOYxSIWeCzpc6ORK7sl/z26lxe+TcEDYk5yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgeUr496kglvJLbnOlYeAz/PqG5sqrASiOT/uZLEncjZMahDKFFMsc4mcDtQJ+60I
	 AGUiYwK8iE9nF0SWInIlLlewkojFTViQy5nfIvi1XbiFrknTVuX173i2zFEJfOHJqm
	 1O58hiAjdlkE+6tt2+34AjEWCBEZPGfyiKDh8mpSf8MrGTSOT7RwvxUcZNDHpAMx0j
	 kTgDCzNFn6YlU7WwrftOS3EJJCuTY8lifkCHa7MJYcDx59Jr2ujAxjUT9Z6LzJFjW0
	 b8vijCniJEpxEJagDeACDtUExDU/pm+GpgBr1P3dz4ia5J11MdyUNaYvnT3ZJxjsTR
	 1YUXWyJRRjppg==
Date: Fri, 18 Apr 2025 10:32:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	eranian@google.com, songliubraving@meta.com, ravi.bangoria@amd.com,
	ananth.narayan@amd.com
Subject: Re: [PATCH v2 0/5] perf/x86/uncore: Overflow handling enhancements
Message-ID: <aAIOGkKWGOLbu6y-@gmail.com>
References: <cover.1744906694.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744906694.git.sandipan.das@amd.com>


* Sandipan Das <sandipan.das@amd.com> wrote:

> Sandipan Das (5):
>   perf/x86/amd/uncore: Remove unused member from amd_uncore_ctx
>   perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for detecting overflows
>   perf/x86/amd/uncore: Use hrtimer for handling overflows
>   perf/x86/amd/uncore: Add parameter to configure hrtimer
>   perf/x86/amd/uncore: Prevent UMC counters from saturating

Could you please fix your mailer to not mutiliate Cc: lines?

Cc: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org
Cc: mingo@redhat.com
Cc: acme@kernel.org
Cc: namhyung@kernel.org
Cc: mark.rutland@arm.com
Cc: alexander.shishkin@linux.intel.com
Cc: jolsa@kernel.org
Cc: irogers@google.com
Cc: adrian.hunter@intel.com
Cc: kan.liang@linux.intel.com
Cc: tglx@linutronix.de
Cc: bp@alien8.de
Cc: dave.hansen@linux.intel.com
Cc: x86@kernel.org
Cc: hpa@zytor.com
Cc: eranian@google.com
Cc: songliubraving@meta.com
Cc: ravi.bangoria@amd.com
Cc: ananth.narayan@amd.com

All these email addresses have real names, I suppose they weren't just 
written in in such a fashion?

Thanks,

	Ingo
