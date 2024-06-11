Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B040862;
	Tue, 11 Jun 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123400; cv=none; b=MZbJPB3k33t3Mr+5CmbbjECJ2T56xQveZQblkdtnfbKISXN/8NvRNliNrajNtdV9eKQRfPpH8xDF4I4N2wOgLEVKMbeyJLSEqUAdp/eg6TVd/gqA2FHJKtzNW8vnzYx991JRDQpKyBbt/NJN3zElOlBm3B86cyp18OJ/r4TxaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123400; c=relaxed/simple;
	bh=x88vPd67F51bwNIvdn5aIPG/KAt9yYbLHZCemaaxtC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMmJ+/5rubiJu6Pn5KQwYwbOdwHqDXTfL/scLnFqrqF2pUn+owWbsPFrYTvYJ6cZJjS7KhqjEdm4BgadjE2S77i9vPbolvmAX0/VBVZtpdVMIODw00ftp18GDnMYyYH1/myXrL+pgCf1CEU6kW2rPhEEFTsRECLgZA1Rqs7sqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4EdXyOx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4EdXyOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718123398; x=1749659398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x88vPd67F51bwNIvdn5aIPG/KAt9yYbLHZCemaaxtC8=;
  b=B4EdXyOxXUO14hMQIRPCURkZyzyOxxoo3Utl+tiWmNNgimDe+HPqXzgP
   5mVmkENePu9P0k2ipTQiv4G3WJYxsWStodn9W/3EDPsQXvH3kJQBpKyc5
   D5tzT6TH5gOB2FqKyakQQ4VwM74BWW6SMZn+/V7/yv0CclKDbTTDx1pGV
   /vYU9UH9FSW4GHgRBBYf8BW3NbLM1kGQTtu3u43juWe24lUEir9MU67mv
   I0vFAFPsIj4Eb+edf386n2erGNQket0jGhCEEw+cXIG9qKBOXRjnjmLgz
   gnt0O92MX9t6uC23vGnSHvYQjmIB6kWuPaKnO1ELyTkDa/GRpjmYkENlx
   w==;
X-CSE-ConnectionGUID: XEHyzu6XShuEjS96yVZ3cg==
X-CSE-MsgGUID: HLnwBWRWSHCKx2JHlARiyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15018212"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="15018212"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:29:58 -0700
X-CSE-ConnectionGUID: aW9cfQpQSjqJjDLJ6LBtXA==
X-CSE-MsgGUID: 0uVim8UwQsCsM1J9UsyyeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40204656"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:29:54 -0700
Message-ID: <9dedd378-ce85-4329-b770-de47548bf380@intel.com>
Date: Tue, 11 Jun 2024 19:29:49 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/14] tools/perf: Add support to use libcapstone in
 powerpc
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
 disgoel@linux.vnet.ibm.com
References: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com>
 <20240601060941.13692-12-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fXGPHMF+5cUu42ns0=qm9QCPg0LNUveLLnjdGHPCnVg3w@mail.gmail.com>
 <c383b404-727c-4564-a66e-0906348891b3@intel.com>
 <81ED04E0-23B5-44AE-B84D-5766346F1D32@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <81ED04E0-23B5-44AE-B84D-5766346F1D32@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/06/24 15:20, Athira Rajeev wrote:
> 
> 
>> On 3 Jun 2024, at 10:28 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 3/06/24 19:30, Ian Rogers wrote:
>>> On Fri, May 31, 2024 at 11:10 PM Athira Rajeev
>>> <atrajeev@linux.vnet.ibm.com> wrote:
>>>>
>>>> Now perf uses the capstone library to disassemble the instructions in
>>>> x86. capstone is used (if available) for perf annotate to speed up.
>>>> Currently it only supports x86 architecture. Patch includes changes to
>>>> enable this in powerpc. For now, only for data type sort keys, this
>>>> method is used and only binary code (raw instruction) is read. This is
>>>> because powerpc approach to understand instructions and reg fields uses
>>>> raw instruction. The "cs_disasm" is currently not enabled. While
>>>> attempting to do cs_disasm, observation is that some of the instructions
>>>> were not identified (ex: extswsli, maddld) and it had to fallback to use
>>>> objdump. Hence enabling "cs_disasm" is added in comment section as a
>>>> TODO for powerpc.
>>>>
>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>> ---
>>>> tools/perf/util/disasm.c | 148 ++++++++++++++++++++++++++++++++++++++-
>>>> 1 file changed, 146 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>>>> index d8b357055302..915508d2e197 100644
>>>> --- a/tools/perf/util/disasm.c
>>>> +++ b/tools/perf/util/disasm.c
>>>> @@ -1540,12 +1540,18 @@ static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
>>>> {
>>>>        struct annotation_options *opt = args->options;
>>>>        cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
>>>> +       int ret;
>>>>
>>>>        /* TODO: support more architectures */
>>>> -       if (!arch__is(args->arch, "x86"))
>>>> +       if ((!arch__is(args->arch, "x86")) && (!arch__is(args->arch, "powerpc")))
>>>>                return -1;
>>>>
>>>> -       if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
>>>> +       if (arch__is(args->arch, "x86"))
>>>> +               ret = cs_open(CS_ARCH_X86, mode, handle);
>>>> +       else
>>>> +               ret = cs_open(CS_ARCH_PPC, mode, handle);
>>>> +
>>>> +       if (ret != CS_ERR_OK)
>>>>                return -1;
>>>
>>> There looks to be a pretty/more robust capstone_init function in
>>> print_insn.c, should we factor this code out and recycle:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/print_insn.c?h=perf-tools-next#n40
>>
>> On a slightly related note, there is a compile error
>> been around for a while in util/disasm.c on Ubuntu 22.04
>>
>> In file included from /usr/include/capstone/capstone.h:279,
>>                 from util/disasm.c:1354:
>> /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong
>> kind of tag
>>   94 | typedef enum bpf_insn {
>>      |              ^~~~~~~~
>>
> 
> Hi Adrian
> 
> I tried compilation on Ubuntu 22.04, but didn’t face this issue.
> The libcapstone version I have is libcapstone4 which doesn’t have the include for “bpf.h”
> What is the version of libcapstone in the setup where you are seeing this issue ?

Yes, sorry. I got confused.  Ubuntu was OK.  The original issue
was with Fedora 40, but even then it requires binutils-devel
and BUILD_NONDISTRO=1

