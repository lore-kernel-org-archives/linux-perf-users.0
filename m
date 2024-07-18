Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F61459E8;
	Thu, 18 Jul 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325790; cv=none; b=DDU5GTmnXQgfbVjKZu2cYGt8dJy5n/kfuuBJlM80oE++Qb6L4Zy9tshhMMkKf/GEwdcKEuCmOfZzworWeGw80OlnE9BCPAIud/lNU0iT6+at7eP/ehWx7sWXiDq8OEQpAwLwBAZeWjgdPZ7wUL+JD1jsty/tJB9+WoY43mpJw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325790; c=relaxed/simple;
	bh=K+/D8ITQUYmyYg/+lBxDVcGiVjdI665hHS7auH4ZLKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APTDR12glDqqf4R8z+mmHPFG5wbDdwP2eFV5ZWWBAoQsDMemO3NqU5eL0CCmxgS7fwAMENrJ3BJ4LCPVlpu0/bfTv63/ZIwd7UwHd7HEByjD+uauYAFQK01YsLSXuQMqCSuKszgxm5deY8C+8MFegz9vBkVY1etLuWHR6rMwA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpuSmyE2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpuSmyE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721325789; x=1752861789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K+/D8ITQUYmyYg/+lBxDVcGiVjdI665hHS7auH4ZLKk=;
  b=UpuSmyE2RCNr/UUDrN05sKr0Ob2PpDU6s6hEM5E1ofPooZ6WJpzBxxUu
   VmP149azrIW2CyP7nOgMZneMDwQbmYaOmGnfRkIUajedBE0O1Ti0g8LKR
   uEKN7CDRqAqbepNUfvT5Xl51+cUpjz5VBnDrSd0tEpTI2mTlGV0YBBOoO
   N1IivDyMf4QwncaYL1KxKpD/2DI+HweUOAJETTQNUqT8PAsbkIA5NxaZS
   8hVufGWw9xbfIP1bPvEaaom5QiAAc0T/r0Oki7yn1IHS1zSuUmLIRft5Y
   7bxh60eCRm9eB60Sz0R7Wti2kMI4RV5X6ih2DW6kWbFtVCRO4n86fKeyd
   Q==;
X-CSE-ConnectionGUID: RIOZx6h2RqOhi5Rhj6YZ9w==
X-CSE-MsgGUID: izn2i6qtQ86NJdi/9Upo8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="29488996"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="29488996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 11:03:04 -0700
X-CSE-ConnectionGUID: Hz/Q4zT2RNK9u6N0cZut+w==
X-CSE-MsgGUID: 7xcXBoFSR0mgyHRXGzC0iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="50915618"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 11:02:36 -0700
Received: from [10.212.127.244] (kliang2-mobl1.ccr.corp.intel.com [10.212.127.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0F42D20CFED5;
	Thu, 18 Jul 2024 11:02:32 -0700 (PDT)
Message-ID: <2e76dd74-b702-4401-ade1-fc1fd1ff40ce@linux.intel.com>
Date: Thu, 18 Jul 2024 14:02:32 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-7-irogers@google.com>
 <febefab7-7351-4bd5-a6cc-a0116248484f@linux.intel.com>
 <CAP-5=fUUcehu-C=ytHVVixOpeCYoW4oJkkj6p6W=M0HtQ2wrRA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUUcehu-C=ytHVVixOpeCYoW4oJkkj6p6W=M0HtQ2wrRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-18 11:12 a.m., Ian Rogers wrote:
> On Thu, Jul 18, 2024 at 7:41 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
>>> The -C option allows the CPUs for a list of events to be specified but
>>> its not possible to set the CPU for a single event. Add a term to
>>> allow this. The term isn't a general CPU list due to ',' already being
>>> a special character in event parsing instead multiple cpu= terms may
>>> be provided and they will be merged/unioned together.
>>>
>>> An example of mixing different types of events counted on different CPUs:
>>> ```
>>> $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1
>>>
>>>  Performance counter stats for 'system wide':
>>>
>>> CPU0              368,647      instructions/cpu=0/              #    0.26  insn per cycle
>>> CPU4        <not counted>      instructions/cpu=0/
>>> CPU5        <not counted>      instructions/cpu=0/
>>> CPU8        <not counted>      instructions/cpu=0/
>>> CPU0        <not counted>      l1d-misses [cpu]
>>> CPU4              203,377      l1d-misses [cpu]
>>> CPU5              138,231      l1d-misses [cpu]
>>> CPU8        <not counted>      l1d-misses [cpu]
>>> CPU0        <not counted>      cpu/cpu=8/
>>> CPU4        <not counted>      cpu/cpu=8/
>>> CPU5        <not counted>      cpu/cpu=8/
>>> CPU8              943,861      cpu/cpu=8/
>>> CPU0            1,412,071      cycles
>>> CPU4           20,362,900      cycles
>>> CPU5           10,172,725      cycles
>>> CPU8            2,406,081      cycles
>>>
>>>        0.102925309 seconds time elapsed
>>> ```
>>>
>>> Note, the event name of inst_retired.any is missing, reported as
>>> cpu/cpu=8/, as there are unmerged uniquify fixes:
>>> https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/
>>>
>>> An example of spreading uncore overhead across two CPUs:
>>> ```
>>> $ perf stat -A -e "data_read/cpu=0/,data_write/cpu=1/" -a sleep 0.1
>>>
>>>  Performance counter stats for 'system wide':
>>>
>>> CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=0/
>>> CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=0/
>>> CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=1/
>>> CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=1/
>>> CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=1/
>>> CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=1/
>>> ```
>>>
>>> Manually fixing the output it should be:
>>> ```
>>> CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=0/
>>> CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=0/
>>> CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=1/
>>> CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=1/
>>> ```
>>>
>>> That is data_read from 2 PMUs was counted on CPU0 and data_write was
>>> counted on CPU1.
>>
>> There was an effort to make the counter access from any CPU of the package.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6a2f9035bfc27d0e9d78b13635dda9fb017ac01
>>
>> But now it limits the access from specific CPUs. It sounds like a
>> regression.
> 
> Thanks Kan, I'm not sure I understand the comment. 

The flag is also applied for the uncore and RAPL.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/events/intel/uncore.c?&id=e64cd6f73ff5a7eb4f8f759049ee24a3fe55e731

So specifying a CPU to an uncore event doesn't make sense. If the
current CPU is in the same package as the asked CPU. The kernel will
always choose the current CPU.

Thanks,
Kan
> The overhead I was
> thinking of here is more along the lines of cgroup context switches
> (although that isn't in my example). There may be a large number of
> say memory controller events just by having 2 events for each PMU and
> then there are 10s of PMUs. By putting half of the events on 1 CPU and
> half on another, the context switch overhead is shared. That said, the
> counters don't care what cgroup is accessing memory, and users doing
> this are likely making some kind of error.
> 
> Thanks,
> Ian
> 
