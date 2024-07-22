Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E143169;
	Mon, 22 Jul 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636958; cv=none; b=AkdO34L2TTAZaobkHv35dwOKGB5o/7we1fU6WOdbYSTZA7eHAJ9247qGOPme9npaoX1DXYfTh4Kov6lIBIlvdiYBXAIjOsG3CUOFSqYpdVLjCh1dNthjJ2jl2Juw+AHGOQFEts1vCMvPjc5EXHpW0xGkw3iLRFDk/bk7X5PaoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636958; c=relaxed/simple;
	bh=WVUiUZZrhSyC5ogpqbKGLX1PHFwhFxJSq6enD4jXS94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKaDTS98jTLE4pKbxYKp4/tm+3cWQ4idCFNFIW5bNdfl3fa0v2XINKsMJfF9CyqTede5adzyEWPhoBjKdD3Z/xNBvV63v9lwChJPIWsA86p2RC1MOLM2zaQyrp1QKbwevLrnwbxzFxru/shyGKoleIY2mHC8fNATMjY8+EQiXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gF1qUUwL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gF1qUUwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721636957; x=1753172957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WVUiUZZrhSyC5ogpqbKGLX1PHFwhFxJSq6enD4jXS94=;
  b=gF1qUUwLnbOm2uUHJkbMfaYe/im94HMrNaGN7OD1DjOHb5hN4nhmv+M9
   KBQ3hKGQhDpEPZUoQxRM7j1yTBCWnF+2c2QzeWwQaUr9INSi2iVjnj9Fq
   FXX9MF6OvB33lyptZZ/RSoYlUYa3Vut9ejpPoEkuTLyRrGwpf2T52AGMO
   HWw7ppp6bCHvWO8a+GK08qVpXJza6vgf43/ateBQi60g9WXOlleUMiWlT
   fZFntsUYj+Ty5ElZxUVMNWB39QVprPfuVYvmTxcGM+ROx+yxiH2vpSXmi
   v0DyvoeWQXv5xTFyKXdzqKkP0DggwZO4pMCg8zR56OOmFTY3BwprZfAYc
   w==;
X-CSE-ConnectionGUID: y/WIla70TNOjP6CxxIlNLw==
X-CSE-MsgGUID: hWBXZLeXRHCMyye3ayOrOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="44618478"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="44618478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 01:28:55 -0700
X-CSE-ConnectionGUID: qxVdrlWkQOOjlTuJ3O6rdQ==
X-CSE-MsgGUID: RxoZp5BWT42LIo+ODeZ7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="56092103"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 01:28:48 -0700
Message-ID: <05fa0449-4fd4-41ed-93e8-db825e48268f@intel.com>
Date: Mon, 22 Jul 2024 11:28:44 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240718010023.1495687-1-irogers@google.com>
 <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/07/24 19:26, Ian Rogers wrote:
> On Fri, Jul 19, 2024 at 1:51 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 18/07/24 03:59, Ian Rogers wrote:
>>> struct perf_tool provides a set of function pointers that are called
>>> through when processing perf data. To make filling the pointers less
>>> cumbersome, if they are NULL perf_tools__fill_defaults will add
>>> default do nothing implementations.
>>>
>>> This change refactors struct perf_tool to have an init function that
>>> provides the default implementation. The special use of NULL and
>>> perf_tools__fill_defaults are removed. As a consequence the tool
>>> pointers can then all be made const, which better reflects the
>>> behavior a particular perf command would expect of the tool and to
>>> some extent can reduce the cognitive load on someone working on a
>>> command.
>>>
>>> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
>>
>> The tags were really meant only for patch 1, the email that was replied to.
>>
>> But now for patches 2 and 3:
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Sorry for that, you'd mentioned that pt and bts testing which is
> impacted by more than just patch 1.
> 
>> Looking at patches 4 to 25, they do not seem to offer any benefit.
>>
>> Instead of patch 26, presumably perf_tool__fill_defaults() could
>> be moved to __perf_session__new(), which perhaps would allow
>> patch 27 as it is.
> 
> What I'm trying to do in the series is make it so that the tool isn't
> mutated during its use by session. Ideally we'd be passing a const
> tool to session_new, that's not possible because there's a hack to fix
> ordered events and pipe mode in session__new:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/session.c?h=perf-tools-next#n275
> Imo, it isn't great to pass a tool to session__new where you say you
> want ordered events and then session just goes to change that for you.
> Altering that behavior was beyond the scope of this clean up, so tool
> is only const after session__new.

Seems like a separate issue.  Since the session is created
by __perf_session__new(), session->tool will always be a pointer
to a const tool once there is:

diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 7f69baeae7fb..7c8dd6956330 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -43,7 +43,7 @@ struct perf_session {
 	u64			one_mmap_offset;
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
-	struct perf_tool	*tool;
+	const struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;

> 
> The reason for doing this is to make it so that when I have a tool I
> can reason that nobody is doing things to change it under my feet.

It still can be changed by the caller of __perf_session__new(), since
the tool itself is not const.

Anything using container_of() like:

static int process_sample_event(const struct perf_tool *tool,
				union perf_event *event,
				struct perf_sample *sample,
				struct evsel *evsel,
				struct machine *machine)
{
	struct perf_script *scr = container_of(tool, struct perf_script, tool);

can then change scr->tool without even having to cast away const.

Really, 'tool' needs to be defined as const in the first place.

> My
> builtin_cmd is in charge of what the tool is rather than some code
> buried in util that thought it was going to do me a favor. The code is
> a refactor and so the benefit is intended to be for the developer and
> how they reason about the use of tool.

It creates another question though: since there is a lot of code
before perf_tool__init() is called, does the caller mistakenly
change tool before calling perf_tool__init()

> how they reason about the use of tool. We generally use _init
> functions rather than having _fill_defaults, so there is a consistency
> argument.

The caller does not need the "defaults", so why would it set them up.
The session could just as easily do:

	if (tool->cb)
		tool->cb(...);
	else
		cb_stub(...);

> I don't expect any impact in terms of performance... Moving
> perf_tool__fill_defaults to __perf_session__new had issues with the
> existing code where NULL would be written over a function pointer
> expecting the later fill_defaults to fix it up, doesn't address coding
> consistency where _init is the norm, and adds another reason the tool
> passed to session__new can't be const.

perf_tool__init() is not a steeping stone to making 'tool' a
const in the first place.

