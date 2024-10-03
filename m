Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC426ACD;
	Thu,  3 Oct 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967459; cv=none; b=PXcWoUeMnmOUG8O/bt4F5DzhEv0IdRyFOwRzbIXNQE78hRk/cDeE8GgcN5/ImxHohh6pmwO49YLLg6bZ97YuiXXL2h7UPzlPsf2CWjOjlcxqZmA7xJfiJCWG/RlnhuxKGbaq8J1wCcQqz1iq9Tp6H6C7juMc3IOgS9Mqmbodfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967459; c=relaxed/simple;
	bh=6lVb+SFOz5J/qaruoyw5IIPg/4SorI5aDmc74GIPE+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odGZ2zgAI3DkWdYfI3K1vSNBPctjVKkUC/PGUgjqqe3sxYptF9RRaQ+4oGMyZ8lJaGiTmk2kcePxREbZaqawAP0hVaQQQKq46MY5OkLAaMxmczcq49JLTF/l7EGP2AfYKEa4GFuS2xU/kDZQF5CFf6xLZqusRb9GFN+xP7Q1JPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mx49KkRY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mx49KkRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727967458; x=1759503458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6lVb+SFOz5J/qaruoyw5IIPg/4SorI5aDmc74GIPE+o=;
  b=Mx49KkRY5S3Uk9fh0sfdGCpQdEPEAyrD2q95n2RLF75rdx/MRie2+Lin
   3SXt7ovQlNNwVxNr9p+9lCEy9EtSMnngaqM+a26hVPQefNMZI+3jNHGY/
   FOD01BUpjXdeCemjU6PeEdgTmZj3n8lZFo6H9vaLi5sfPZftgunx209jI
   4Vf4kZbfy7AlG/c13n6PAP16O2ttlA2EJR2qanPVDObC+ZUAvjLor+mSI
   zhZl8MS+lZ289LhaUfxWiJz7JMKYyLxu/Bol1IMbI110T8XbHEYxqgnv1
   HIa6NAwJt/XX4Oa7twjUvmy9pi1JWTgqO73zGXkkkhDEBFLpHKqbsLqGl
   Q==;
X-CSE-ConnectionGUID: 8YUv5dC2QOKVtvZeRvD83A==
X-CSE-MsgGUID: Q0EJzN40Rw6APDRg+auWnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27293293"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27293293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 07:57:14 -0700
X-CSE-ConnectionGUID: ej4iMYwmRkeMWg96A960dA==
X-CSE-MsgGUID: CN9GoFieQU+As3oH24319Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74382111"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 07:57:14 -0700
Received: from [10.212.90.18] (kliang2-mobl1.ccr.corp.intel.com [10.212.90.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5913420B5782;
	Thu,  3 Oct 2024 07:57:12 -0700 (PDT)
Message-ID: <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
Date: Thu, 3 Oct 2024 10:57:11 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-10-02 8:57 p.m., Ian Rogers wrote:
> On Wed, Oct 2, 2024 at 5:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Tue, Oct 01, 2024 at 03:32:04PM -0700, Ian Rogers wrote:
>>> On Tue, Oct 1, 2024 at 2:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
>>>>
>>>>> Changes:
>>>>> v5 -> v6:
>>>>>   * no function change.
>>>>>   * rebase patchset to latest code of perf-tool-next tree.
>>>>>   * Add Kan's reviewed-by tag.
>>>>>
>>>>> History:
>>>>>   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@linux.intel.com/
>>>>>   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
>>>>>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
>>>>>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
>>>>>
>>>>> [...]
>>>>
>>>> Applied to perf-tools-next, thanks!
>>>
>>> I disagreed with an early patch set and the issue wasn't resolved. Specifically:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
>>> ```
>>>   /* Followed by topdown events. */
>>>   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>>   return -1;
>>> - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>>> + /*
>>> + * Move topdown events forward only when topdown events
>>> + * are not in same group with previous event.
>>> + */
>>> + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
>>> +     lhs->core.leader != rhs->core.leader)
>>>   return 1;
>>> ```
>>> Is a broken comparator as the lhs then rhs behavior varies from the
>>> rhs then lhs behavior. The qsort implementation can randomly order the
>>> events.
>>> Please drop/revert.
>>
>> Can you please provide an example when it's broken?  I'm not sure how it
>> can produce new errors, but it seems to fix a specific problem.  Do you
>> have a new test failure after this change?
> 
> It may work with a particular sort routine in a particular library
> today, the issue is that if the sort routine were say changed from:
> 
> if (cmp(a, b) < 0)
> 
> to:
> 
> if (cmp(b, a) > 0)
> 
> the sort would vary with this change even though such a change in the
> sorting code is a no-op. It is fundamental algorithms that this code
> is broken, I'm not going to spend the time finding a list of
> instructions and a sort routine to demonstrate this.


I'm not sure I fully understand. But just want to mention that the
change only impacts the Topdown perf metric group, which is only
available for the ICL and later p-core. Nothing will change if no perf
metrics topdown events are used. Very limited impact.

I like the patch set is because it provides examples and tests to cover
the possible combination of the slots event and topdown metrics events.
So we will have a clear expectation for different combinations caused by
the perf metrics mess.

If the algorithms cannot be changed, can you please give some
suggestions, especially for the sample read failure?

Thanks,
Kan
