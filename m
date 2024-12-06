Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D03D6B;
	Fri,  6 Dec 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474633; cv=none; b=qiPFQKSpMfXx7TKR8Ha7gkH4SvcdQAWt0Hsg/uYKxQEsZ34dK+wAH08Wmpd6fm+h7UNXo8qG5szIFBW+ACYKlgzP81R4VRoKknEgXH4jR3epJcyrbkJvg3nz1azWTTmIoCp70J5Q0mueHsc0wwICYk9G53lhjEC6gn/nYyFz3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474633; c=relaxed/simple;
	bh=+ucPFiXOnczG0nSs5sIHDF2GBW/NjCp/xyHARkz/sKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgadjIoPoAZyFr/cK2WIxZYnMQV+PwNfIlAWGjdmADW3qrAuHlgXIVFBI0XmLu8I1nfxdwNg/duUso88Kr2KuyTFR4mWudM59YenqaPxJ+HFWIVvuoMYgmHuB/323WLWUN8kx5SKxU2tfiCnU11Xm0Q6DoFqdGISCYEl5b5MraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI7yNP5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI7yNP5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E5CC4CED1;
	Fri,  6 Dec 2024 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733474633;
	bh=+ucPFiXOnczG0nSs5sIHDF2GBW/NjCp/xyHARkz/sKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CI7yNP5CJWnrnPR4E8MmYuS8jHg+ALGMLd0who0JLwfvR9JXyqgkm4r3ThEBwndxW
	 /zYAMVjhae9JsveAiZNW1q8smzd704AJl99P/qGkPXb/CRYK5vcAEZ8g+3EDjiOov/
	 NOiwyHo/yPuS5ERbalSESEzKN+VgMbBJSKWqCMsGySmR6rm48p+HU5lSHluH+X3fzT
	 6IWkK7+sbr/js5Q0Q3KXWoR4ySjvo0qaVDVUArs9uSvNUPvjbVKxKTTSg2uOs+rZKI
	 XQKncZnAnscyRxVxX3AF8jS02JY5e8qnOuM+bmF8T9NVDXCuc2n1eoMxF7RTsWUiBS
	 /Sw2LO0eOQ2CA==
Date: Fri, 6 Dec 2024 09:43:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v2 10/10] perf test amd ibs: Add sample period unit test
Message-ID: <Z1K5QQQNly-HuqkP@gmail.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-11-ravi.bangoria@amd.com>
 <cf12a0c4-21bd-4568-9dc8-daaa2392bd94@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf12a0c4-21bd-4568-9dc8-daaa2392bd94@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> On 06-Dec-24 10:47 AM, Ravi Bangoria wrote:
> > IBS Fetch and IBS Op pmus has various constraints on supported sample
> > periods. Add perf unit tests to test those.
> > 
> > Running it in parallel with other tests causes intermittent failures.
> > Mark it exclusive to force it to run sequentially.
> 
> The verbose mode of unit test is quite exhaustive so I've not added it
> in the commit description. Here is the sample output on a Zen5 machine:
> 
> Without patches:

> With patches:

That's not a problem - please include this in the changelog for the 
next version, it's useful information.

Thanks,

	Ingo
