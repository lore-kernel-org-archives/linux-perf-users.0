Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56D191;
	Fri, 19 Sep 2025 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240559; cv=none; b=ca/w8v4J9sWb46XL7zw+9xwkncHieflBy6OFE/SJRpRT1cUu8EVeiNbGST0bK3Q4kqpUqd8q5svOr04xnZsfJwcVeJ3B91DiSXFxZiOgGd9EENiCeKsfvxzZHp078qiH3S18ZE7p7/VeDWd0v/Hma/8OEhxytQKF+AOvBIKUqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240559; c=relaxed/simple;
	bh=mbjZB92TxDhArcKXUR2GBPTMN3cns8vIOAZmwdr2MNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbFn/Zjs6vusmQipIXtc/kwS2R0eGiau0DnihqVN3tc+7y6GXaH13bYwXgd4bjDYVmDIACcq2RO4KLa6rS82z0lz6KrC8zyguSx0pp8JtLbAHECp8JS5jKapXmOz4bpudMZ1o8zU9ZmOLwsrEC/ZV4u8CQxIFXGquyL5VYdNS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYnzTn/R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYnzTn/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758240557; x=1789776557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mbjZB92TxDhArcKXUR2GBPTMN3cns8vIOAZmwdr2MNQ=;
  b=KYnzTn/RJwGdI6Ge5RUCmhQVf53tMIjodHuhpe6n8S70ftoAFtgt8UAX
   78gTULawFVdCKQ+3dd0G2ytr3dENNH8uHbm+kBoC1zFuF19b2XrwPUa13
   FvjFCftwRu58OJchJU7qNs8dfW6paocRiVVpJ/yHFQVO490zFqStLzh3R
   QLkNH8Q64zhpLyWT99o3UCjmwdYSpBVkLS67zCqdgzvfZUeChZgTmHRm3
   D1aJlR/gKaMEkev8EtcmGT3ANCwKspLVW4qDLLsty4kfzfuDVmtufKvyB
   KswX4CNse2W2pmqh05Fkpi9zW8KF2i3a1pKxoOCP7UGYQVvjqorJ7ZlYv
   Q==;
X-CSE-ConnectionGUID: wAkNc017TdaUD4B9WcaiOQ==
X-CSE-MsgGUID: fsjCW0ZjR06nqNnmfsxwjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64405196"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64405196"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:09:16 -0700
X-CSE-ConnectionGUID: HyOZ2EEeQti+glqJKoTEoA==
X-CSE-MsgGUID: Gk1Q12HRQQK7CJv18XI3VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175749657"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.177]) ([10.124.233.177])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:09:13 -0700
Message-ID: <aea7c0f4-e951-484a-962d-f3a9b5b26b57@linux.intel.com>
Date: Fri, 19 Sep 2025 08:09:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fWcf7F1QvWXzAD_KMpOnnKGw9PFM7mNtgzp_jh4Vi6V-w@mail.gmail.com>
 <189e060b-207b-469f-9b6e-314380d12a42@linux.intel.com> <aMxkqnXdrvv9BN8s@x1>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aMxkqnXdrvv9BN8s@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/19/2025 3:59 AM, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 18, 2025 at 07:52:43AM +0800, Mi, Dapeng wrote:
>> On 9/18/2025 5:12 AM, Ian Rogers wrote:
>>> On Sun, Aug 10, 2025 at 10:56 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>>> his patch-set fixes perf kvm commands issues, like missed memory
>>>> allocation check/free, out of range memory access and especially the
>>>> issue that fails to sample guest with "perf kvm record/top" commands on
>>>> Intel platforms.
>>>>
>>>> The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
>>>>  default event") changes to use PEBS event to do sampling by default
>>>> including guest sampling. This breaks host to sample guest with commands
>>>> "perf kvm record/top" on Intel platforms.
>>> Huh? That change is:
>>> ```
>>> $ git show 634d36f82517
>>> commit 634d36f82517eb5c6a9b9ec7fe3ba19dbbcb7809
>>> Author: Namhyung Kim <namhyung@kernel.org>
>>> Date:   Tue Oct 15 23:23:58 2024 -0700
>>>
>>>     perf record: Just use "cycles:P" as the default event
>>>
>>>     The fallback logic can add ":u" modifier if needed.
>>> ...
>>> -               bool can_profile_kernel = perf_event_paranoid_check(1);
>>> -
>>> -               err = parse_event(rec->evlist, can_profile_kernel ?
>>> "cycles:P" : "cycles:Pu");
>>> +               err = parse_event(rec->evlist, "cycles:P");
>>> ...
>>> ```
>>> isn't the precision the same before and after? I think you've blamed
>>> the wrong patch.
>>>
>>> The change to use cycles:P looks to come from commit 7b100989b4f6
>>> ("perf evlist: Remove __evlist__add_default") but the old code was
>>> doing things like "evsel->precise_max = true;" so I think I was just
>>> carrying forward behavior. The use of precise_max comes from commit
>>> 4e8a5c155137 ("perf evsel: Fix max perf_event_attr.precise_ip
>>> detection") from over 6 years ago, and the behavior before that also
>>> appears to have been to use the maximum supported precision.
>>>
>>> Apart from the blame and commit message being off I think the change
>>> is okay, delta my usual complaint that weak symbols are the devil's
>>> work.
>> Hmm, yeah, you're right. Thanks for correcting this. 
> Hi Dapeng,
>
> 	Can you please fix the patch descriptions and Fixes references
> and resubmit?

Sure. would do. Thanks.


>
> - Arnaldo
