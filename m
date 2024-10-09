Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B613AA27;
	Wed,  9 Oct 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455249; cv=none; b=TEgwFzLH4BbJk9iZdS50oFdhWGHhnZ2u5v8t25aFTMIMbWY1mVU8UkcYz/fOf+WtMQcVSQiQO7GSQ+16Y4jsiKwILDtZIsXy/KCQO2gbQPmzlIY2rqaAjs/MyoTXgNTy+nvREjp430KvfPVtcB9J8fp6KOIyGdPiNvFaZ/Gxsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455249; c=relaxed/simple;
	bh=SmcTTBQFs6IHyJfeTxZFPH0jk1GC9H7FJOa7OF2F5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDiTRbba5Pk1Gk+kwrspsdzM/XP2Pz/l85tfvjIuGnQnJ/QriKVZgdKcpEfbi5pHuAhdtk16enXURkVSLHZDfRz3KQuL87PrzNOg1vVjO7xxwsUa2QwlNU/Frwr0egfL//RSRoOGTC9hKd4MhngdufccRVj/LYMDS6VHn9bWnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ5YmZG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ5YmZG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E3FC4CEC5;
	Wed,  9 Oct 2024 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728455249;
	bh=SmcTTBQFs6IHyJfeTxZFPH0jk1GC9H7FJOa7OF2F5ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJ5YmZG56PYuz1WmLdyvtRChJjkwyfyRFeni25foP2GKBasnE2aOUUh29iTHOu6+4
	 mS5JM5W8axoGOi3ddjKSFEH1iarrGd6IOZBJI0MjD24oSI1FeXFRIyhslFZ2wYiE78
	 Ov1OXKrYvw6DR3jasKSSe9xW8TAuoVqyww49W3ABKTaEdsiokjrMsY/UNu+STZSK2c
	 WgoVhLUWdmVMowxVUisNVhXC8EcYmFAa5l1/ZWVMDtjnS8KEnxVnu7Wi30h+RM2Gu/
	 cyDLnjxZKR/CQ8/Zm5iHcH8C+Alo/697CgIrqkb41cvKv81FNVDEN+uxQuM0wfZQEu
	 Pp2/Nyk2RgITQ==
Date: Tue, 8 Oct 2024 23:27:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 5/8] perf/amd/ibs: Don't allow freq mode event creation
 through ->config interface
Message-ID: <ZwYiTvrcVkF4W7O3@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-6-ravi.bangoria@amd.com>
 <ZwQ1cRhRuE3kunjK@google.com>
 <79ccf66b-6bf0-4cc8-b001-aae44f09dde9@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79ccf66b-6bf0-4cc8-b001-aae44f09dde9@amd.com>

On Tue, Oct 08, 2024 at 11:00:37AM +0530, Ravi Bangoria wrote:
> >> Don't allow freq mode event creation through perf_event_attr->config
> >> interface.
> > 
> > Sounds reasonable.  I agree the freq mode should use the standard
> > interface using attr->sample_freq.  But I'm not sure if the behaivor is
> > defined when attr->freq is set and attr->sample_freq is 0.  Maybe this
> > should be handled in the generic code.
> 
> I also could not find any reason to allow {freq=1, sample_freq=0}, but:
> 
> 1) perf_event_open() allows it.
> 2) ioctl(PERF_EVENT_IOC_PERIOD) allows it.
> 3) all generic code explicitly checks for ->sample_freq != 0 wherever
>    ->freq == 1.
> 
> I will prepare and post a patch to reject such event and see if there
> are any objections.

Hmm.. now I think that the kernel won't treat it as a sampling event and
would ignore the attr.freq value.  Setting IOC_PERIOD to 0 would disable
sampling then.  Sorry for the noise.

Thanks,
Namhyung

