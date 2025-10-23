Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225F8405C;
	Thu, 23 Oct 2025 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257481; cv=none; b=NF9b7KZsYffJ0cJ2+Tdo1F+ZYp1i01NcR2S57yhaElHM+3gZypCafqOLnvs9vWb/swDCV4IiIyyc/OpeeA41WNgYCSNmwZSLp9EzVBp22/1isPwFR1R6QvLoglI9yuRUHcazmoAZRstdLDbEcIf8Fr57lvOcXtMVQD2gi1w3IyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257481; c=relaxed/simple;
	bh=nmrxt0pWUJZ6JqvHMmNY6vhSh4t/+5RrRkIo43hz+fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1iNgA0LNCdSmFDXqCXo0o/jl82i1SAZ+bkc9aIJyl+RatkC3CRaFEM3NhWSyk86B26XBwMLUACTqkvJV7ZkPMQxLolEh3RQpUEQGP6/O1PmyFCq+1neAENrXY2OKvOfmP4IIfmK8cYDW4TLiMwt/H2kM/5YXGKBJwYdebAZpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUBqjoi6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUBqjoi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761257479; x=1792793479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nmrxt0pWUJZ6JqvHMmNY6vhSh4t/+5RrRkIo43hz+fA=;
  b=DUBqjoi6a0ve8SUFb6w45vsLbIdTQAjkQX/XsyFiDcX6ItJk70z59Vmt
   xc1+drXILyNHU9a8l1wiZlVbveZ7wb50zsJCs4CgRgeODHwcLDqOEr7RK
   JEOYwNA1dn7gGKA9NbAZTwx0RihMKGGwatNN+T1HvQvRjXm9Ryo/eGJLN
   KM2q+Opnu6f6Sy+W3ZKhHa58iwTcPNMfMuYdJu6DwEIimsvCfoy42smZX
   8iIcl213L9Z9ODNmjjPWIkQ2buZBIivWM9oHe0vXOtMXrNmt9LCxfZ9qx
   Tl1w3ezSr9GULmo3IWJRzklUDGGPTVOeEiQSZSB2Lo24glrlu92EyijX3
   w==;
X-CSE-ConnectionGUID: DlfqKZADSrGLlQMx7Z06rA==
X-CSE-MsgGUID: srDguvzGT3St6Ky6H+3Ulg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62470431"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="62470431"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:11:19 -0700
X-CSE-ConnectionGUID: FZogax42RQGJW8M3RNN4rQ==
X-CSE-MsgGUID: 7qEFBgt8TGqSfG41hAc3ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184342221"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.181]) ([10.241.241.181])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:11:10 -0700
Message-ID: <5c3e30ac-7fe3-47fb-923e-3def7902a772@intel.com>
Date: Thu, 23 Oct 2025 15:11:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <CAP-5=fUKH8Qw9t173G4HP-UzujUKJrLPPmkDSjBs=2YzV=9LHA@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAP-5=fUKH8Qw9t173G4HP-UzujUKJrLPPmkDSjBs=2YzV=9LHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/23/2025 9:14 AM, Ian Rogers wrote:
> On Wed, Oct 22, 2025 at 3:14 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>> unconditionally called the precise_ip fallback and moved it after the
>> missing-feature checks so that it could handle EINVAL as well.
>>
>> However, this introduced an issue: after disabling missing features,
>> the event could fail to open, which makes the subsequent precise_ip
>> fallback useless since it will always fail.
>>
>> For example, run the following command on Intel SPR:
>>
>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>
>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
>> kernel check failure since it doesn't match the group leader's inherit
>> attribute. As a result, it continues to fail even after precise_ip is
>> reduced.
>>
>> By moving the precise_ip fallback earlier, this issue is resolved, as
>> well as the kernel test robot report mentioned in commit
>> c33aea446bf555ab.
>>
>> No negative side effects are expected, because the precise_ip level is
>> restored by evsel__precise_ip_fallback() if the fallback does not help.
>>
>> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
>> evsel__handle_error_quirks()").
>>
>> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
>> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Any chance you could help with a test case that covers this? The
> fallback logic is spread out and easy to introduce subtle bugs into.
> Just having a test case that does ` perf record -e
> '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls` and checks the
> output for EINVAL when the events are present would be useful, as then
> we can make sure this doesn't regress on SPR and later. Something with
> more generic events would of course be better :-)

OK. Maybe a new test "PMU event open fallback tests".
