Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2191B808
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922207; cv=pass; b=IZCYm2+ZsMBWJmI8B1f1Y7A2oNpJIVTFNYinmp6AwYySn3WYgCSP9R6ikr2kORd60KNXD8Tqk0ZpEraxWULJCXV9ohJmNQZVVSDyxB9l7Le2yFkRu4ZrjXLDc+YVs9YIYmLXP9mMq9sNo4HZ0AWu+wnLco5KlN9obIg/Kr3Snqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922207; c=relaxed/simple;
	bh=RlQQm/KgNhHAJ9uha6TUzPPZEoKEw0uqWF+NRqjljiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl8wBirienwSIrZwnrEyQAx+8rVIyJ8uoDMIagTAeiQOqQP4vc4w6KYB61OKPih5C+ILE5LXA9KojE8uS1e8AwgStZ7pFl4tB0bAPIL+MQ1O8h20j4MFK2d3McFCFQoz56qIx6mqHm2HyrGSfFePTT57G7TRDFPJEDerVXobFao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1N135Jd; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1N135Jd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aad8123335so6315ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 10:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770922204; cv=none;
        d=google.com; s=arc-20240605;
        b=LjQ9U0/NBYbaJwGdTS9t7RH+66n9/6ke5TBZToOFwnZwtzSiPwzo5ZVVrnyPfIwe+9
         V+/xFrv/L7gO8mERcMPb0EDzaDdKN/nvNbhn46NMjpim3lBQrmFZHG7VAjHukelf54zo
         jxHrwzKpEfdbi5vn2PtoxWr5nlQKe6uNteKOREU65t9xGVvn3KO3DzaMq60U36e01Tx8
         ke3RIEqXLbapWGBXU6gzGJxAEQylg1T28y8RSE3nFFaCsk2Zwy18QtViwTt9i9XZ7cBH
         mF8nz/PPZImlSbl4b7JeykxpwuwLerKoTfOtc96KcSUPf0BW+uP3xqvr7hMQR3Qr/GHj
         eASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPuCW932IFyia6cjtLvR9VgL7zJH46CZShO30RmPl7w=;
        fh=ZF8EWlkcgCXLJf39ktedsqeQ/ps/0q8o+mtaC8fU6v8=;
        b=lYLv9OJT7QuSuj320F5HvXBYeGT3Tdzgrk/iaZqZ4FYbgsNNg3KpkJ47PaCXTPi8Zf
         xxnHX2gZ/748vhuyI0Y81izdyz9IEuARuzYSoDZZ3Dn4YFie3o180ryQ+atd6ZV9z//3
         vw3wOVPPuKYNBvCQKtTuZGGgibfWPcjEmiTvM+mIXH29gyZmuHjJmdJMhu/CMaefVnCR
         xEIxK8z1tnBoaRpuYsCbb3YF9Dcp0os8/9/GAll8oWeYGpb1cTI02cgWjKbrUSyCONBT
         WrY+8KFa9Lk4gWWDsyp81S0ZdlF+TtDnsa+YdEcwD3POeGwaaK0xs5qGFrFAcTNmd2BT
         1hog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770922204; x=1771527004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPuCW932IFyia6cjtLvR9VgL7zJH46CZShO30RmPl7w=;
        b=n1N135JdD5ktVJ/mieAJgNO+4enLJXS5ftGmbDSCSn74twhCTBgDeRumS4Mfc3LGBI
         tCBFHJqj49msPX7af0dHcuBoUtnwgu3U2Y8vlXTYX+b9NTvgunhoFs7lRXf3fUfth+ye
         eVvdSfwETYLKny/RaCN+sRRfb7zNbGSVorMOZOgo7ICESaggh9CKyjAFjM4iIDP0TdZ/
         BsOZVccdEwOiIaqxioH0R8qzLL8ZHM9EDzh4HYQW4DDQMcquyI73U1bfwcV/l1yiPznS
         +qcqIyuADoPdjp6aqWwWX6GgzXjxUeMYOn67Whir1XvgYUEUYHdVNUYt+m7fxOEhkG4M
         mJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770922204; x=1771527004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZPuCW932IFyia6cjtLvR9VgL7zJH46CZShO30RmPl7w=;
        b=JWvxxXPyMOPYE2wMv8qS8Y9SebVnFkvzOzRzJDZeAV4lt2rxRBUpBCf1+z8EMSBIHf
         cpoRx2f1vW+JlR/B5XNCU7izVLVNUM0K6TBWsCkes1SVJYWYkckfyknvlkfqXaEtyNsk
         vUYBHdpEkKJx87ofEikwZPdU2gMYRs3xiCXgIrWurIrzfOFpmMG//IPryRMHNOpb4hpe
         pA332jOjFMi4V7IjofSRqqky7zcWKg7Ca7yA4ltkm2nQ2fDJo/nVULLEx0zbMDD5rn2n
         P3L7EQWZy1PSUWirvyh7AqJfbIxMORqJ4DOgACKsSxxFgQUvRxfoNJmkiL6AQVAH+Rxy
         P17w==
X-Forwarded-Encrypted: i=1; AJvYcCVWL/zRSQb234ssV4uJV6x8cOJLac+8s/X7wiVHBkPzv8qS/VY3ggqfJ2XnWIDvq49lN2kC4EnK8l3CRelVbeQv@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzEgelXK/fWbwu8C6j8EZ+dTB9lNZfXZ21WuumKpdGfTewi03
	2mhDFCG+IKQ+3gYLlkPqiSsb3WXm6Led4tsBzA7TS6BDxo0tYbMh1/DUeqYPH5fP2cLBDCoZFiS
	QUG+T29019pxBpWpT6H7cIekPMU082XVOgiAS3yUB
X-Gm-Gg: AZuq6aISA95n0ggWTdH86PAukAWfh9+zokwXkYtX3pql3tMPtnFQFml8JoTwGosngsR
	pgOLycEkMP4ZrIMTiXW7I9oWECUrfX9rTQBx+skxO7clj1KFxEazi2kAfjvtormusXkL77NciBo
	XQCnrUlaDDarZulxD8XS81ZnVuYhWiawGBYENlWMeOuqsT3gF0fQ5oYIz1V11eRtWnWBbUU+JQY
	Y4gK6C1vyPMm883qqOqsinVCrr6RG62A/FgXBP/ggJpbQbImcLwgalIhk5gvKb8Q3auZKlz1nGe
	FRGt0FOUBKoVrUNYB4pSMqQnOBJzf8QYy1Sn
X-Received: by 2002:a17:903:32c1:b0:2a0:89b0:71d6 with SMTP id
 d9443c01a7336-2ab4c7e4f86mr136845ad.17.1770922203374; Thu, 12 Feb 2026
 10:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202602122137.a1396559-lkp@intel.com>
In-Reply-To: <202602122137.a1396559-lkp@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Feb 2026 10:49:51 -0800
X-Gm-Features: AZwV_QiUHF0uXq3EDUoFrpLzyRagjVdNtq0BhT4zQAfPpDTy6RItQ_AWnXpSzts
Message-ID: <CAP-5=fUOdSF8QJVezSVv+WzTy45bVubw+JbyB1JEfuT3PYedyA@mail.gmail.com>
Subject: Re: [linux-next:master] [perf test] 54a23bff77: perf-sanity-tests.test_addr2line_inline_unwinding.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, James Clark <james.clark@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Tony Jones <tonyj@suse.de>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 6:16=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> Hello,
>
>
> for new added "test addr2line inline unwinding", we found it failed consi=
stently
> in our tests. not sure if we miss any dependency. below report is FYI.
>
>
> kernel test robot noticed "perf-sanity-tests.test_addr2line_inline_unwind=
ing.fail" on:
>
> commit: 54a23bff770961e024e2c61cd1f46888190c3e79 ("perf test: Test addr2l=
ine unwinding works with inline functions")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
>
> in testcase: perf-sanity-tests
> version:
> with following parameters:
>
>         perf_compiler: clang
>         group: group-02
>
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602122137.a1396559-lkp@intel.=
com
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260212/202602122137.a1396559-lk=
p@intel.com
>
>
> 2026-02-10 04:50:32 sudo ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D0 /usr/sr=
c/linux-perf-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/t=
ools/perf/perf test 76 -v
>  76: test addr2line inline unwinding                                 : Ru=
nning (1 active)
> --- start ---
> test child forked, pid 11320
> Inline unwinding verification test
> [ perf record: Woken up 136 times to write data ]
> [ perf record: Captured and wrote 33.858 MB /tmp/perf-test-inline-addr2li=
ne.v74NZkItW4/perf.data (4206 samples) ]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D11324=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 61808 byte(s) in 8 object(s) allocated from:
>     #0 0x7fb5922e0610 in calloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:77
>     #1 0x7fb5920c1808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #2 0x7fb5920c25f9  (/lib/x86_64-linux-gnu/libelf.so.1+0x45f9) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #3 0x5560ff9ea997 in symsrc__init util/symbol-elf.c:1164
>     #4 0x5560ff56702e in dso__load util/symbol.c:1795
>     #5 0x5560ff5fb064 in map__load util/map.c:351
>     #6 0x5560ff5fb44b in map__find_symbol util/map.c:385
>     #7 0x5560ff47a46d in thread__find_symbol util/event.c:725
>     #8 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
>     #9 0x5560ffa85240 in report_module util/unwind-libdw.c:117
>     #10 0x5560ffa86a99 in frame_callback util/unwind-libdw.c:248
>     #11 0x7fb59206dae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/li=
bdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #12 0x7fb59206de53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/li=
bdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #13 0x5560ffa8763d in unwind__get_entries util/unwind-libdw.c:307
>     #14 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c=
:2977
>     #15 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
>     #16 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.=
c:1818
>     #17 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
>     #18 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/built=
in-record.c:1504
>     #19 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
>     #20 0x5560ff61f490 in machines__deliver_event util/session.c:1432
>     #21 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
>     #22 0x5560ff60c775 in ordered_events__deliver_event util/session.c:13=
4
>     #23 0x5560ff64a011 in do_flush util/ordered-events.c:245
>     #24 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:3=
24
>     #25 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
>     #26 0x5560ff617d42 in perf_event__process_finished_round util/session=
.c:787
>     #27 0x5560ff621c1d in perf_session__process_user_event util/session.c=
:1583

Hmm.. this looks a lot like this 1 liner fix is missing:
https://lore.kernel.org/lkml/20260117052849.2205545-2-irogers@google.com/
but it is in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
tools/perf/util/symbol-elf.c?id=3D92d65d9c31621befe0a5f7c0bd43bd217613c6b6

> Direct leak of 4424 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb5922e0610 in calloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:77
>     #1 0x7fb5920c1808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #2 0x7fb5920c25f9  (/lib/x86_64-linux-gnu/libelf.so.1+0x45f9) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #3 0x5560ff9ea997 in symsrc__init util/symbol-elf.c:1164
>     #4 0x5560ff56702e in dso__load util/symbol.c:1795
>     #5 0x5560ff5fb064 in map__load util/map.c:351
>     #6 0x5560ff5fb44b in map__find_symbol util/map.c:385
>     #7 0x5560ff47a46d in thread__find_symbol util/event.c:725
>     #8 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
>     #9 0x5560ffa85240 in report_module util/unwind-libdw.c:117
>     #10 0x5560ffa874ca in unwind__get_entries util/unwind-libdw.c:299
>     #11 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c=
:2977
>     #12 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
>     #13 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.=
c:1818
>     #14 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
>     #15 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/built=
in-record.c:1504
>     #16 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
>     #17 0x5560ff61f490 in machines__deliver_event util/session.c:1432
>     #18 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
>     #19 0x5560ff60c775 in ordered_events__deliver_event util/session.c:13=
4
>     #20 0x5560ff64a011 in do_flush util/ordered-events.c:245
>     #21 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:3=
24
>     #22 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
>     #23 0x5560ff617d42 in perf_event__process_finished_round util/session=
.c:787
>     #24 0x5560ff621c1d in perf_session__process_user_event util/session.c=
:1583
>     #25 0x5560ff6249ac in perf_session__process_event util/session.c:1805
>     #26 0x5560ff62c265 in process_simple util/session.c:2399
>     #27 0x5560ff62b225 in reader__read_event util/session.c:2328
>
> Indirect leak of 18368 byte(s) in 8 object(s) allocated from:
>     #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
>     #1 0x7fb5920c9550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #2 0x7fb5920ca517  (/lib/x86_64-linux-gnu/libelf.so.1+0xc517) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #3 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0=
xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #4 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
>     #5 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086

Here is the read_gnu_debugdata, so "type =3D=3D
DSO_BINARY_TYPE__GNU_DEBUGDATA" on line 1171 should be true. I'm
failing to eyeball where there is a missing elf_end (the allocation
happens inside an elf_begin). The code is:
```
Elf *embedded =3D read_gnu_debugdata(dso, elf, name, &new_fd);

if (!embedded)
goto out_elf_end;

elf_end(elf);
...
out_elf_end:
elf_end(elf);
```

So I believe the issue is that the fix above wasn't applied when this
test was run, but I'm not sure how that could have happened. Fwiw,
local testing didn't reproduce the issue.

Thanks,
Ian

>     #6 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
>     #7 0x5560ff56702e in dso__load util/symbol.c:1795
>     #8 0x5560ff5fb064 in map__load util/map.c:351
>     #9 0x5560ff5fb44b in map__find_symbol util/map.c:385
>     #10 0x5560ff47a46d in thread__find_symbol util/event.c:725
>     #11 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
>     #12 0x5560ffa85240 in report_module util/unwind-libdw.c:117
>     #13 0x5560ffa86a99 in frame_callback util/unwind-libdw.c:248
>     #14 0x7fb59206dae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/li=
bdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #15 0x7fb59206de53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/li=
bdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #16 0x5560ffa8763d in unwind__get_entries util/unwind-libdw.c:307
>     #17 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c=
:2977
>     #18 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
>     #19 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.=
c:1818
>     #20 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
>     #21 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/built=
in-record.c:1504
>     #22 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
>     #23 0x5560ff61f490 in machines__deliver_event util/session.c:1432
>     #24 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
>     #25 0x5560ff60c775 in ordered_events__deliver_event util/session.c:13=
4
>     #26 0x5560ff64a011 in do_flush util/ordered-events.c:245
>     #27 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:3=
24
>
> Indirect leak of 3203 byte(s) in 8 object(s) allocated from:
>     #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
>     #1 0x7fb5920ca3fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #2 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0=
xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #3 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
>     #4 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
>     #5 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
>     #6 0x5560ff56702e in dso__load util/symbol.c:1795
>     #7 0x5560ff5fb064 in map__load util/map.c:351
>     #8 0x5560ff5fb44b in map__find_symbol util/map.c:385
>     #9 0x5560ff47a46d in thread__find_symbol util/event.c:725
>     #10 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
>     #11 0x5560ffa85240 in report_module util/unwind-libdw.c:117
>     #12 0x5560ffa86a99 in frame_callback util/unwind-libdw.c:248
>     #13 0x7fb59206dae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/li=
bdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #14 0x7fb59206de53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/li=
bdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #15 0x5560ffa8763d in unwind__get_entries util/unwind-libdw.c:307
>     #16 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c=
:2977
>     #17 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
>     #18 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.=
c:1818
>     #19 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
>     #20 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/built=
in-record.c:1504
>     #21 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
>     #22 0x5560ff61f490 in machines__deliver_event util/session.c:1432
>     #23 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
>     #24 0x5560ff60c775 in ordered_events__deliver_event util/session.c:13=
4
>     #25 0x5560ff64a011 in do_flush util/ordered-events.c:245
>     #26 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:3=
24
>     #27 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
>
> Indirect leak of 1280 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
>     #1 0x7fb5920c9550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #2 0x7fb5920ca517  (/lib/x86_64-linux-gnu/libelf.so.1+0xc517) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #3 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0=
xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #4 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
>     #5 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
>     #6 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
>     #7 0x5560ff56702e in dso__load util/symbol.c:1795
>     #8 0x5560ff5fb064 in map__load util/map.c:351
>     #9 0x5560ff5fb44b in map__find_symbol util/map.c:385
>     #10 0x5560ff47a46d in thread__find_symbol util/event.c:725
>     #11 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
>     #12 0x5560ffa85240 in report_module util/unwind-libdw.c:117
>     #13 0x5560ffa874ca in unwind__get_entries util/unwind-libdw.c:299
>     #14 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c=
:2977
>     #15 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
>     #16 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.=
c:1818
>     #17 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
>     #18 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/built=
in-record.c:1504
>     #19 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
>     #20 0x5560ff61f490 in machines__deliver_event util/session.c:1432
>     #21 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
>     #22 0x5560ff60c775 in ordered_events__deliver_event util/session.c:13=
4
>     #23 0x5560ff64a011 in do_flush util/ordered-events.c:245
>     #24 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:3=
24
>     #25 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
>     #26 0x5560ff617d42 in perf_event__process_finished_round util/session=
.c:787
>     #27 0x5560ff621c1d in perf_session__process_user_event util/session.c=
:1583
>
> Indirect leak of 190 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
>     #1 0x7fb5920ca3fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #2 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0=
xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>     #3 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
>     #4 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
>     #5 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
>     #6 0x5560ff56702e in dso__load util/symbol.c:1795
>     #7 0x5560ff5fb064 in map__load util/map.c:351
>     #8 0x5560ff5fb44b in map__find_symbol util/map.c:385
>     #9 0x5560ff47a46d in thread__find_symbol util/event.c:725
>     #10 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
>     #11 0x5560ffa85240 in report_module util/unwind-libdw.c:117
>     #12 0x5560ffa874ca in unwind__get_entries util/unwind-libdw.c:299
>     #13 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c=
:2977
>     #14 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
>     #15 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.=
c:1818
>     #16 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
>     #17 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/built=
in-record.c:1504
>     #18 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
>     #19 0x5560ff61f490 in machines__deliver_event util/session.c:1432
>     #20 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
>     #21 0x5560ff60c775 in ordered_events__deliver_event util/session.c:13=
4
>     #22 0x5560ff64a011 in do_flush util/ordered-events.c:245
>     #23 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:3=
24
>     #24 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
>     #25 0x5560ff617d42 in perf_event__process_finished_round util/session=
.c:787
>     #26 0x5560ff621c1d in perf_session__process_user_event util/session.c=
:1583
>     #27 0x5560ff6249ac in perf_session__process_event util/session.c:1805
>
> SUMMARY: AddressSanitizer: 89273 byte(s) leaked in 27 allocation(s).
> Unexpected signal in test_inlinedloop
> ---- end(-1) ----
>  76: test addr2line inline unwinding                                 : FA=
ILED!
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
