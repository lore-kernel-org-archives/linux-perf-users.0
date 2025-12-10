Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44095285C84
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393446; cv=pass; b=piIxwwys+D4nVDE27ChD7n81Oosb0g1OT8Ix5w8lKXUoJWCsZv51J4aDT71/XIoNNzjdrLdI1a1KlNlhaPUfd9lH1hLxSLnEcXXxcxWG/25T2vPqv/9W8UIcJDp3ZcRQ8e4APXOOJ3D06aHTiw1iODSvLJzwYJgI9uQ/wOoVsqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393446; c=relaxed/simple;
	bh=Sc9TTyn1dGTg9IGilKJEzhrVRHXnAW5Eq9JJHTJZXFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mk5O6AyFXgQaWWxiE8/pou6M4Uvo3jiRk/esV98AZMPazostYn1ulAdtzbcc/KUpTjs2rDl3RrtjoCu/2cLgK8+qFCDrU/tuEVIuvwcWr1cUbibYErhtBfLLNEKcs9COpRBHqxRpqNp4hau4OzjanG7ctKLWZe0ONDyQUvffFlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBzs28oB; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBzs28oB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980343d9d1so18185ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 11:04:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765393443; cv=none;
        d=google.com; s=arc-20240605;
        b=AsVz6z3B41zPHfNl682F+5Yc8dlGAupPMbCJesv0BjaMBM1IhXHfR+cRCbDtCHc1no
         053nmoQNiuCZJAQoYm4lxGKk/8BSwSapfTO8U8io2Rvjvzzfh7odvF2Oau2+RrorvvBV
         WXsCV8jrUF9H4mdIYBcb4mhBR9CG90USP8N3DiaVwY4xHiSTWY9IBHfwxMehmoXl0VUQ
         dlt5Esqhhyq/6mOLKbqkNP4Be34JX+bHHuhk5nlwSB3HhCWPmjz8F2Am/ydu1FzGRCK5
         JTqkut1NgTxE1V6q8DelJ7t2ZmJRmdITmNB7T2qW37qYg73LiJ2fKV11EnV/qCq0wAjX
         3TEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hjMbajRZHQK4q2oeOhzXh+hyw+4D3o92ugguBehohuk=;
        fh=7b7PYP3Uut9YBLT+axzFW4hTOQVTYaf/ig6qakCNcwI=;
        b=TKx7eXFVkw1VbdK77cF69B8z7OP1nk9f/WVayXstys4WQ+OwxijOWWSkSomRRlz5VK
         mmkkl9GV9Ef/uCGdL5fMmDGa44J/ivT+d0jqx9PyWN1meLHgMeh4Gnxuzf9tyiKiwS45
         qLspevY+Zm1QRiwYQwzd8qy2VX3HMm2Mnx2s+CkpU1UZ7wWIFRy2YfEA9AaYz/vJ+vHe
         Y7Mi183OHyzOOYN6ZixtFuZKYyNWYVC6CgRHYKBzwiRWiqYvLkm/PwfB/CSq0S33U3av
         mzJG93YKEgjxE3ciOYkQgNgPZUdfIvt7iS5vvWRy5oovOp4IQcWLrtWSD110y2jRa0bM
         npbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765393443; x=1765998243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjMbajRZHQK4q2oeOhzXh+hyw+4D3o92ugguBehohuk=;
        b=cBzs28oBXGSWLgNZKKrtX2La7bTMcIWqBCpr5LBYbUAlIWHRvuAFU6fY7L5JlLA4aI
         upNWTTkUgRIXRp6qliOLzhdKCVU02CsLPrrKyNo6Mcck/7Xct4bB46BKkW8MRZQ9ncs6
         dSUVtf8RGrtbzU0SAivzNV6rTQbhN7YleSdQuh6ccSIXpTJhEoY8y50eJBN64/ADP+uc
         DkHLEsZqYwsC6sTUX7jqSrc3HTOtjzPjLgfbRt3D6mE+p98YubO7PFXOGAlaTVy3p/7f
         5Q28GiLyyfvHpsTCZMGksuoD/BCHwEgF2Aj42VqCQVUSo2SmLLJfnEzeoRiqTpnVg/ip
         TKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393443; x=1765998243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjMbajRZHQK4q2oeOhzXh+hyw+4D3o92ugguBehohuk=;
        b=vk6GvI8xRSnqd34XxjRSGcNm4Vxa3ZUHmCdDeNDMwIgPALM+k8Fg4oYIaQA8IGZD0J
         plsQxav100EflXA2B/CKTCijh4fBgHlKO8riMO5icPABfPBPHAtjU2P82mq2DoHkrt5Z
         h8MzrxDYo0XhZsnMy3Anibz/2HUAEBY7PwwjO1UO5HgA41p5WXB8pNT/Pj5+5tsw+Q7w
         ZH4L7YjPux6wgHc6dXG2gvFWQtEWXREXi4g3UHB1OgxRJOnzOS68WYqk4NXgHgXTdhqK
         TcUzXrcyduaicdQGwVaXhFkwVH8CTFgQrHbIktV4d1DSgI2qtIy8crOi4sqCRRK0gpyA
         EnwA==
X-Forwarded-Encrypted: i=1; AJvYcCX73c3S7MKVexB37mKfocHhTlSziwsOkMd8Q00kxNyN0l8dAPOnqEueMuEP45iKLVgaVv4XR0LE+np3zEF6Ksuw@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKK309t7nNZBDTMW7ihIKdAP9moejrZWOzYzb3fOvKxIlECs0
	pwvWDGx9k3cGXroOxe5waJYbQJNkkb/T6t6VJguBTGsoZcDA6YybWug8CyT5yglIJjVjRy/4Tc2
	0xD+VspJg/7gptG2afFvNsJcviUvkMuM9u9G7NfgW
X-Gm-Gg: AY/fxX6I6Z/WMqhfodzpLCm1Xr9FhjuJ8gJra09FHEVSZB5ILY73QOqbGPYR2s2Cav4
	w1f5H7CauR/NBe2ktXWEvec5mffBDxwOb2SDzATSdznKnu77SwR2UVuHz0rv3AC8wKcVljDPPsx
	/j9MOD6V/KT6VqPToXpw941TSgk/Kmj0QcAhCihkO7ED45+Rb8WTCCgtpKRHdU4UQOzNyxD8Vpz
	T3OARNpBIsALePTtui9ivMOtQBPmUwxvTmHQYA+88KlpiiEeBJ2M1QhDNWYWnpGFw3LdN1tlDP5
	IoBLNvHJPsLaMSHJYInEEAW7zw==
X-Google-Smtp-Source: AGHT+IGtHeC8733UvPqO1jOzDofCqrTfuKtmpmWxtjbth0Nf3hs3Qp2Iw6u+OKSsFmBQFc21BTzvZhxc1m+xZ4+D5gE=
X-Received: by 2002:a17:903:1a84:b0:297:f0aa:d466 with SMTP id
 d9443c01a7336-29eea1f8a47mr274095ad.8.1765393443133; Wed, 10 Dec 2025
 11:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202512101502.f3819cd3-lkp@intel.com>
In-Reply-To: <202512101502.f3819cd3-lkp@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 11:03:52 -0800
X-Gm-Features: AQt7F2q-jiP_E9suh0wGMOq3C1D1AhdZx2TeP9vPnjNQcYkjqGay1HRBlJIJOQw
Message-ID: <CAP-5=fW68j1tCH7_r=y7Mp1OAnWgJfZQ9hF0FvVkW9pThE_+NA@mail.gmail.com>
Subject: Re: [linus:master] [perf test] 34e271ae55: kmsg.sanitizer.indirect_leak/calloc/zalloc/dso__new_id/__dsos__addnew_id/__dsos__findnew_id/dsos__findnew_id
To: kernel test robot <oliver.sang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 12:09=E2=80=AFAM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
>
> besides the indirect_leak mentioned in title, we also observe below diffe=
rence
> if comparing to parent commit.
>
>
> 4fba95fc383f9231 34e271ae55382fbdb04f3e13e85
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :8           75%           6:6     kmsg.sanitizer.direct_leak/=
malloc/map__get/maps__find_symbol_by_name_cb/maps__for_each_map/maps__find_=
symbol_by_name/machine__find_kernel_symbol_by_name
>            :8           75%           6:6     kmsg.sanitizer.indirect_lea=
k/calloc/map__new2/__machine__create_kernel_maps/machine__create_kernel_map=
s/test__kallsyms_split/run_test_child
>            :8           75%           6:6     kmsg.sanitizer.indirect_lea=
k/calloc/symbol__new/map__process_kallsym_symbol/kallsyms__parse/dso__load_=
all_kallsyms/__dso__load_kallsyms
>            :8           75%           6:6     kmsg.sanitizer.indirect_lea=
k/calloc/zalloc/dso__new_id/__dsos__addnew_id/__dsos__findnew_id/dsos__find=
new_id
>            :8           75%           6:6     kmsg.sanitizer.indirect_lea=
k/malloc/dso__get/map__init/map__new2/__machine__create_kernel_maps/machine=
__create_kernel_maps
>            :8           75%           6:6     kmsg.sanitizer.indirect_lea=
k/malloc/symbols__sort_by_name/dso__sort_by_name/map__find_symbol_by_name_i=
dx/map__find_symbol_by_name/maps__find_symbol_by_name_cb
>
>
> but we don't have enough knowledge to understand if they are expected by =
the
> change is 34e271ae55, so just make out below report FYI.
>
>
> kernel test robot noticed "kmsg.sanitizer.indirect_leak/calloc/zalloc/dso=
__new_id/__dsos__addnew_id/__dsos__findnew_id/dsos__findnew_id" on:
>
> commit: 34e271ae55382fbdb04f3e13e856457d8e0dee45 ("perf test: Add kallsym=
s split test")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linux-next/master 6987d58a9cbc5bd57c983baa514474a86c945d5=
6]
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
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz=
 (Coffee Lake-E) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202512101502.f3819cd3-lkp@intel.=
com

Thanks! Reproduced and posted a fix:
https://lore.kernel.org/linux-perf-users/20251210190141.12725-1-irogers@goo=
gle.com/

Ian

>
> Indirect leak of 386 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0248972610 in calloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:77
>     #1 0x561eb21740b6 in zalloc ../../lib/zalloc.c:8
>     #2 0x561eb2529d8f in dso__new_id util/dso.c:1527
>     #3 0x561eb25327bb in __dsos__addnew_id util/dsos.c:329
>     #4 0x561eb253287d in __dsos__findnew_id util/dsos.c:351
>     #5 0x561eb2532907 in dsos__findnew_id util/dsos.c:358
>     #6 0x561eb25d267f in machine__findnew_dso_id util/machine.c:3191
>     #7 0x561eb25d26ce in machine__findnew_dso util/machine.c:3196
>     #8 0x561eb252778e in machine__findnew_kernel util/dso.c:1338
>     #9 0x561eb25bbfe0 in machine__get_kernel util/machine.c:969
>     #10 0x561eb25c0d10 in machine__create_kernel_maps util/machine.c:1545
>     #11 0x561eb231f3be in test__kallsyms_split tests/kallsyms-split.c:117
>     #12 0x561eb223b4d8 in run_test_child tests/builtin-test.c:340
>     #13 0x561eb218d899 in start_command /usr/src/perf_selftests-x86_64-rh=
el-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/lib/subcmd/run-co=
mmand.c:128
>     #14 0x561eb223d9b4 in start_test tests/builtin-test.c:545
>     #15 0x561eb223e920 in __cmd_test tests/builtin-test.c:648
>     #16 0x561eb22412d3 in cmd_test tests/builtin-test.c:850
>     #17 0x561eb214751d in run_builtin /usr/src/perf_selftests-x86_64-rhel=
-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:349
>     #18 0x561eb2147e0e in handle_internal_command /usr/src/perf_selftests=
-x86_64-rhel-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/pe=
rf.c:401
>     #19 0x561eb2148364 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:445
>     #20 0x561eb2148b0b in main /usr/src/perf_selftests-x86_64-rhel-9.4-bp=
f-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:553
>     #21 0x7f023e69aca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildI=
d: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
>
>
> more details are in below link.
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251210/202512101502.f3819cd3-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
