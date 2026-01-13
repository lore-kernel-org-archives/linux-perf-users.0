Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503038E5E9
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305837; cv=none; b=aZJOznDoMK58IlF8N0LyMFuWkC1i2ASu+9bD34EObqVgPeJJAUMK/4mP6npjtmJgotEoTHzbSb2lYmN4bb13CKhcoYCf7O0GscKxp4ctVB22KE3b6FayJfVE+ZQCtFUu1MhUXjkp9/lxcier3Bba8Drs5k42l9IpQhLlgpc+N+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305837; c=relaxed/simple;
	bh=K07/9rYQ/X8TqnYzpPYYZheU2TouT7N4KJC5QAHmuqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFSXT6g2bJ1VnRTC9VkfNglzqWQzsSmlRWjz46znlMiUjt+6IJT+Zl4R85rL8mseZTF9pfDN9gEj0VztCS8vCTIwQut0oRCQHh3eGbDskxqHxTl/OIQpz2NWKspapKogvLK1YnKkacKTLeMxS4XAMO+DawP8ihjDLHNdRmUc9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeX72AdQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeX72AdQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so3884192f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 04:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768305833; x=1768910633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59gtP1BRMDdEifwZkGv64YjY+AgTF7S00qD96F8Nhi8=;
        b=TeX72AdQsvyT1TT6+KGUMw65Knz94HHaSd04KQKSOlTsHU+biELKbQtUzN4L6pwFh4
         ai5pEZyV5wsISFbhJK0yygtrUHCmhC7wXRg+lxm6nHWfLAgwVVG/nayHmnP5N7fIyf0b
         /QdjkpOsd1J1TdRq/5M/kvULLkS8TwKvysy0chfOJ5+cx4/g/7hR94cI3ENY1ot/PfXr
         dIHFCjXUk/I1mZt4R2L+fnS9M5D8gtztkUKpdREBSVGDHn7dudKvc5/JFm7TpPUNUeID
         qIIZzeQr9+6jtsULEN/EDha9ZmmT7ybYTezDDWAGC4Q2X8hnhBF+bNGntNCRmnUWJ6HR
         EmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768305833; x=1768910633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59gtP1BRMDdEifwZkGv64YjY+AgTF7S00qD96F8Nhi8=;
        b=BxfgNV1qjtt1REuL7LeZlHJUOkqiiPcMFPJIG9F3iacX5sHmt9MP4zHfbYT5DAvOjJ
         Zox4K+OUDK4mOSfYybu2jL9sP3jtb/BzcqaV0/FNWs7R/Udfv0/hoXAkgUwrU2PK1+m2
         AV1MeyQIqE1S290ra6iCMjxVk9Z/md9Ny2OXou9biRPv4t3a9s+WmbGHJfbryrfP+dXM
         C4nhrxjL3gulOQJC2PXSi2QQPraHAibU92qDPXcqBQeL0GW90jdoh2MS1pD+5dtf2wL8
         HflcsjanZBfAGKHvNPcAO6PdDbSh5Z4nA1dUWpUjktSXd3GGao8sMwtgNs1Uj7696pJg
         wAHA==
X-Forwarded-Encrypted: i=1; AJvYcCV+1csJGm1UiSUOlJU4Fl3E1ZgeciyX2mPvo6l43VdaLGsIFh07qhW3qcF6ZqWOIGocPkVu1DXYhCgf5b8SAxzU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxijj0/1z5WcLI/dS9iLj+y/fN+lA9Mt3aIQruQXGVkGIyfKL1Q
	M4xjexByej9e6yXCsjYgO988cLl4Ll3M4yS3gNK5kw2rTo3wv7vqDWvY1RP/gVWx5P8=
X-Gm-Gg: AY/fxX5n9vEYFlIR0i/0MF0D19IpNBsyEHNC0SvC2poNFuy9fuy8K/bGWybkvHAnfPR
	3wbkJLxuMPpB5Tx0I0AYokHJArh3skVmc9LQJBb8GmvKhN12q7IRuviW1ea5MrWDJIiZt4MEdTB
	0TOicijSivq9XTbiDtsFm8gj62pSzOB+cq9JOVQGYAv2hrSDpL91rlWH7cKHfcNsiq4/+JXiovW
	uAV0s4uiX65i7jwqjiTUR6Pa3x+DLwUQqyBd0x85Z4wH0mdq5L/tn4c5BIn0dH1WI/m6GctrWnK
	jWVEWRoCUC/CTccAHg1H7mRZ/tmbETCameHdKM94SJJNcfFnckWWbUmCZl84FgscAeU+T84uv4O
	Km/nRO+q6VlPDKzXRbMFLupZ+Rc+JdDFOhn4QpYge8gfXbZfrku8FQCjZ5LiuipAJLBHhbEqqHb
	/MCi4S/3uR1ADn1Swu5oM2o+v1iII=
X-Google-Smtp-Source: AGHT+IEC1gGMDCUMvHGKq3zOOi8fffJWNnMuIgcIqsDEQsP1o+i71dOo1bYQMl1MLSjRiK9dx0K9vg==
X-Received: by 2002:adf:ea03:0:b0:432:d9ef:3bdc with SMTP id ffacd0b85a97d-432d9ef3f40mr13150449f8f.46.1768305832674;
        Tue, 13 Jan 2026 04:03:52 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dfa6dc4esm22006917f8f.23.2026.01.13.04.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 04:03:52 -0800 (PST)
Message-ID: <9f1182a6-fac7-41b0-b6db-24ff64afa8b2@linaro.org>
Date: Tue, 13 Jan 2026 12:03:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf: Add a libdw addr2line implementation
To: Ian Rogers <irogers@google.com>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260111041338.1817056-1-irogers@google.com>
 <dbdd0541-0a67-4d61-9ae2-7820920e8f7a@linaro.org>
 <CAP-5=fWWHHioXCsZhxL=ooEPD_qZyd78t0Qjj1ieZYSB-Z_fsg@mail.gmail.com>
 <CAP-5=fVm8NfxyQcEEpKqLeXEGhzzruNFY=sBXGFzyiftQCPWPA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVm8NfxyQcEEpKqLeXEGhzzruNFY=sBXGFzyiftQCPWPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/01/2026 6:29 pm, Ian Rogers wrote:
> On Mon, Jan 12, 2026 at 6:49 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Mon, Jan 12, 2026 at 3:18 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>> On 11/01/2026 4:13 am, Ian Rogers wrote:
>>>> addr2line is a performance bottleneck in perf, add a libdw based
>>>> implementation that avoids forking addr2line and caches the decoded
>>>> debug information.
>>>>
>>>> Allow the addr2line implementation to be picked via the configuration
>>>> file or --addr2line-style with `perf report`.
>>>>
>>>> Test/fix that inline callchains are properly displayed by perf script.
>>>>
>>>> An example:
>>>> ```
>>>> $ perf record --call-graph dwarf -e cycles:u -- perf test -w inlineloop 1
>>>> [ perf record: Woken up 132 times to write data ]
>>>> [ perf record: Captured and wrote 32.814 MB perf.data (4074 samples) ]
>>>> $ perf script --fields +srcline
>>>> ...
>>>> perf-inlineloop 1814670 293100.228871:     640004 cpu_core/cycles/u:
>>>>               55a11d6e61ee leaf+0x2e
>>>>     inlineloop.c:21 (inlined)
>>>>               55a11d6e61ee middle+0x2e
>>>>     inlineloop.c:27 (inlined)
>>>>               55a11d6e61ee parent+0x2e (perf)
>>>>     inlineloop.c:32
>>>>               55a11d6e629b inlineloop+0x8b (perf)
>>>>     inlineloop.c:47
>>>>               55a11d69a3bc run_workload+0x5a (perf)
>>>>     builtin-test.c:715
>>>>               55a11d69aa9f cmd_test+0x417 (perf)
>>>>     builtin-test.c:825
>>>>               55a11d6155f5 run_builtin+0xd4 (perf)
>>>>     perf.c:349
>>>>               55a11d61588d handle_internal_command+0xdd (perf)
>>>>     perf.c:401
>>>>               55a11d6159e6 run_argv+0x35 (perf)
>>>>     perf.c:445
>>>>               55a11d615d2f main+0x2cb (perf)
>>>>     perf.c:553
>>>>               7fae3d233ca7 __libc_start_call_main+0x77 (libc.so.6)
>>>>     libc_start_call_main.h:58
>>>>               7fae3d233d64 __libc_start_main_impl+0x84
>>>>     libc-start.c:360 (inlined)
>>>>               55a11d565f80 _start+0x20 (perf)
>>>>     ??:0
>>>> ...
>>>> ```
>>>>
>>>> v3: Make the caller inline file and line number accurate in the libdw
>>>>       addr2line, rather than using the function's declared location.
>>>>       Fix reference counts in unwind-libdw. Add fixes tag for srcline
>>>>       inline printing.
>>>>
>>>> v2: Fix bias issue with libdwfl functions. Use cu_walk_functions_at
>>>>       from perf's dwarf-aux to fully walk inline functions. Add testing
>>>>       that inlined functions are shown in the perf script srcline
>>>>       callchain information. Add configurability as to which addr2line
>>>>       style to use.
>>>>       https://lore.kernel.org/lkml/20260110082647.1487574-1-irogers@google.com/
>>>>
>>>> v1: https://lore.kernel.org/lkml/20251122093934.94971-1-irogers@google.com/
>>>>
>>>> Ian Rogers (7):
>>>>     perf unwind-libdw: Fix invalid reference counts
>>>>     perf addr2line: Add a libdw implementation
>>>>     perf addr2line.c: Rename a2l_style to cmd_a2l_style
>>>>     perf srcline: Add configuration support for the addr2line style
>>>>     perf callchain: Fix srcline printing with inlines
>>>>     perf test workload: Add inlineloop test workload
>>>>     perf test: Test addr2line unwinding works with inline functions
>>>>
>>>>    tools/perf/builtin-report.c                 |  10 ++
>>>>    tools/perf/tests/builtin-test.c             |   1 +
>>>>    tools/perf/tests/shell/addr2line_inlines.sh |  47 ++++++
>>>>    tools/perf/tests/tests.h                    |   1 +
>>>>    tools/perf/tests/workloads/Build            |   2 +
>>>>    tools/perf/tests/workloads/inlineloop.c     |  52 +++++++
>>>>    tools/perf/util/Build                       |   1 +
>>>>    tools/perf/util/addr2line.c                 |  20 +--
>>>>    tools/perf/util/config.c                    |   4 +
>>>>    tools/perf/util/dso.c                       |   2 +
>>>>    tools/perf/util/dso.h                       |  11 ++
>>>>    tools/perf/util/evsel_fprintf.c             |   8 +-
>>>>    tools/perf/util/libdw.c                     | 153 ++++++++++++++++++++
>>>>    tools/perf/util/libdw.h                     |  60 ++++++++
>>>>    tools/perf/util/srcline.c                   | 116 ++++++++++++++-
>>>>    tools/perf/util/srcline.h                   |   3 +
>>>>    tools/perf/util/symbol_conf.h               |  10 ++
>>>>    tools/perf/util/unwind-libdw.c              |   7 +-
>>>>    18 files changed, 486 insertions(+), 22 deletions(-)
>>>>    create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
>>>>    create mode 100644 tools/perf/tests/workloads/inlineloop.c
>>>>    create mode 100644 tools/perf/util/libdw.c
>>>>    create mode 100644 tools/perf/util/libdw.h
>>>>
>>>
>>> I don't see the differences to the other addr2line implementations
>>> anymore, but only because it falls through to the old ones when libdw
>>> fails now.
>>>
>>> For example when building Perf with LLVM it can't get the line in the
>>> inlineloop workload, and there's still a few things in libc and other
>>> system libraries it fails on.
>>
>> Hmm.. I wonder what the issue is. I was looking at the dwarf output
>> from my gcc builds with llvm-dwarfdump. I wonder if LLVM builds are

I see some issues in libc on Ubuntu though, which I assume is compiled 
with GCC, although there's no .comment section in it so I can't be sure. 
So it's not exclusively LLVM but it does seem like LLVM builds cause a 
lot more failures.

>> doing something to confuse libdw? I'll try to investigate. There are
>> quite a few levels of libdw: there's the raw libdw, libdwfl (frontend
>> to libdw) that does the parsing and tries to give things like nested
>> debug scopes (libdwfl is the one needing addresses with a module bias
>> rather than raw file offsets), and then there is the dwarf-aux.c that
>> is in perf and is used by things like probe finding (I believe this
>> doesn't need biases addresses). Anyway, with the biases there are
>> things I can screw up (like in the v1 patch) but maybe the LLVM issue
>> is just a libdw and dwarf-5 kind of thing. Maybe it is ARM specific
>> :-/

Actually I get the same behavior on Arm and x86.

> 
> Testing with clang/llvm on x86-64 (dwarf5):
> ```
> $ make -C tools/perf O=/tmp/perf DEBUG=1 CC=clang CXX=clang++
> HOSTCC=clang clean all
> ...
> $ llvm-dwarfdump /tmp/perf/perf
> ...
> 0x0014f852: Compile Unit: length = 0x00000294, format = DWARF32,
> version = 0x0005, unit_type = DW_UT_compile,
> abbr_offset = 0x1879a, addr_size = 0x08 (next unit at 0x0014faea)
> 
> 0x0014f85e: DW_TAG_compile_unit
>               DW_AT_producer    ("Debian clang version 19.1.7 (3+build5)")
>               DW_AT_language    (DW_LANG_C11)
>               DW_AT_name        ("tests/workloads/inlineloop.c")
>               DW_AT_str_offsets_base    (0x0004a550)
>               DW_AT_stmt_list   (0x0008c3f2)
>               DW_AT_comp_dir    ("linux/tools/perf")
>               DW_AT_low_pc      (0x00000000001e61c0)
>               DW_AT_high_pc     (0x00000000001e62e9)
>               DW_AT_addr_base   (0x00022248)
>               DW_AT_loclists_base       (0x0000018a)
> ...
> $  sudo /tmp/perf/perf record --call-graph dwarf -e cycles:u --
> /tmp/perf/perf test -w inlineloop 1
> ...
> $  sudo /tmp/perf/perf script --fields +srcline
> ...
> perf-inlineloop 2284167 423038.015394:     569917 cpu_core/cycles/u:
>             56390020d2c6 leaf+0x26
>   inlineloop.c:21 (inlined)
>             56390020d2c6 middle+0x26
>   inlineloop.c:27 (inlined)
>             56390020d2c6 parent+0x26 (/tmp/perf/perf)
> ...
> ```
> I ran inside of gdb and confirmed that the libdw code is creating the
> inlined information (breakpoint on libdw_a2l_cb, etc.). So I'm not
> able to reproduce the LLVM issue for now on x86-64.
> 
> Thanks,
> Ian
> 

If I set this in ~/.perfconfig so the fallback is disabled:

  [addr2line]
	style = libdw

Then:

  $ make LLVM=1 -C tools/perf DEBUG=1 clean all
  $ perf record --delay 1000 -- perf test -w inlineloop 2
  $ perf script --fields ip,srcline
      6012b5957b70
   perf[1f7b70]
      6012b5957b70
   perf[1f7b70]
   ...


x86:

  $ clang -v
  Ubuntu clang version 15.0.7

Arm:

  $ clang -v
  Ubuntu clang version 18.1.8 (11~20.04.2)

Disabling the ~/.perfconfig to re-enable the LLVM fallback works:

(x86)
$ perf script --fields ip,srcline
      6012b5957b70
   inlineloop.c:20
      6012b5957b70
   inlineloop.c:20

Interestingly, on Arm this results in zeros for line numbers. This is a 
completely different issue though which I didn't notice before because I 
built with GCC. It falls all the way back to A2L_STYLE_CMD:

(Arm)
$ perf script --fields ip,srcline
      aaaad0a7828c
   inlineloop.c:0
      aaaad0a7828c
   inlineloop.c:0

$ addr2line -e `which perf` -a -i -f aaaad0a7828c
0x0000aaaad0a7828c
??
??:0

Probably shouldn't get sidetracked by that here though. It's at least 
working when compiled with GCC, and neither LLVM or libdw work, so it's 
no worse.

>>> But I think it's fine because it doesn't give the wrong line anymore, it
>>> just falls through to another working addr2line implementation.
>>
>> Just to confirm that with gcc builds it isn't failing now? ie it isn't
>> just an addr2line implementation that falls through all the time? I
>> was seeing things working/testing on x86 with gcc.
>>

No, the GCC Perf build always works with libdw as far as I can see. Just 
the occasional fall through to LLVM with some libc addresses.

>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
>> Thanks,
>> Ian

