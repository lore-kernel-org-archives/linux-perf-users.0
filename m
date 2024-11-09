Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70819B5A9
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731169594; cv=none; b=ecROpfFxUa39tWFARAdjWoGeeS7T2xvgf+vjPQSvBK8bApr64yFIWL6iEYyGlKqdgz5a39wagLHpus5iLZcsaVIFk+m8catFADJ1e8xF+yQFjka9i4Y1LTgu8kJKRBWkhn6OFuT75cetoWLXsOMHgdfIpsjyn1ITa28uDjJq2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731169594; c=relaxed/simple;
	bh=X6DcOIRSVQ8Nro7YUsDb33yJfvUboXkH+318jBl2QHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhxRvbn1EAWM9Yp3qoB1i5bj0Ty0u0wJowmPFGbwHuVSId/rIPGpiQRLHlwDmV/zuG3wJvaJoq8d5DaKmQ8L4yAmkNNLGolm/wE5K4aUJZFeUlBS6FYNau4qiNODh+v364PkLjWYj8P2OucR+NzNcJqvLdrjalYSXg0Kq7ptHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBrBWMda; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBrBWMda"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so118525ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 09 Nov 2024 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731169591; x=1731774391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yfKzpu2F7oD0EL8nuutwuKfU/qe3AxHeqS/JVcWCfk=;
        b=fBrBWMdaX389DGv9yj9QDaCQ6BPSiwkxe7d2WGMLy9wd4S4I7z0+Oeph025jSoWSkA
         eN99eT1Cfn+du6pPZg1gxfF8eXUmQc6jOZ+jh/Rgk+2cU35a1d4RPZt1KsWr1/64GUQf
         LNy2qDqNnTxhetW5NKjEG4mbeE7iNkPr0+WMgCVs/cjuRA51YovLy7kS9IKn8IqtcnZr
         Anp9s9X9+amYJTFHDLrG0x8R4z4GtB/DXCRW7aBFSwkLld4JxugaftxNoSzvoHwqTcu4
         lQvwoJCCa4T5h5EFsvhLs9NQTO/AMzHyNNfvkfAfModOwk2ROVvHQswruxM3e+hzYGRj
         xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731169591; x=1731774391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yfKzpu2F7oD0EL8nuutwuKfU/qe3AxHeqS/JVcWCfk=;
        b=CZS7HW13o+Nl6fbjdS2rJmewcNknkmAGSA2fd4WDyAhpaNDDwpfgCe7VLvaxCqCwXl
         7oyJuNXfNK7REsz5qe0ZRIUrhnI/N2jf6oqZzRYva5jU4HqiJtNAq5bHE/mCn0N1Jgt6
         vI/tiuLoX3ECxFaG020ptEEa+xky2dRyxVEw+NJTtFtphVeY3uuPkfE8dSo6pjRd0Yqz
         M8OV0DN8/vFAOWhcA8gL4+Fv0cUzUk2okYDWiZnplE3guYDMDvLHOUL3AQP4dR2n6OXw
         /2QDkFcSGceGTif2Nv1ip30CyvO9kUL4pfiPFdc8fycXJNks45WmillvD17LfOckA9Ks
         xQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCW6DX6UOn1f8h3kM5Zw5AugfOCawozGpfdQQQgrQdHQGhyw3fXb3Nhg0+M3NHK1yxuTtJctXCLMe5udCg9aGQCM@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjmBgp+rsS+76/Ldyw9VN+AQ1B7D8g5rYz4EyLb9llV12QzxM
	9KBZh8NiW9qhuuNEFlJrmEan7GSMoaTg+dx1XiBZZZCXXUEySTdoT38jQlcIW7fPuOibi3E98n/
	xL05x7wSWn7IQxbDG40ooHI3Y6BwoKBAx0Y6/
X-Gm-Gg: ASbGncvVdy8Qdl8z8BMeSHXAgrPNW9HLlnZaxg3jTUcLT1R+68b1limcBANME4Yb/Dm
	wVvEMj62OIod5Gxvw4aYNZlwarvv+s3GQ
X-Google-Smtp-Source: AGHT+IFTLfjgOtMiA8ZjbeqDMMeptCT3ndxFl5gYXqrDkdB0BfmvURY07A0sWUPoOKT+AVpjCd5kag/dL8yZs4+4+mE=
X-Received: by 2002:a05:6e02:1b03:b0:3a0:9f85:d74a with SMTP id
 e9e14a558f8ab-3a6f8a225d9mr2275915ab.14.1731169591393; Sat, 09 Nov 2024
 08:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com> <Zy8FIt2OMa5-GymZ@google.com>
In-Reply-To: <Zy8FIt2OMa5-GymZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 9 Nov 2024 08:26:20 -0800
Message-ID: <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Yang Jihong <yangjihong@bytedance.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Zixian Cai <fzczx123@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > Ian Rogers (6):
> >   tool api fs: Correctly encode errno for read/write open failures
> >   perf trace-event: Constify print arguments
> >   perf trace-event: Always build trace-event-info.c
> >   perf evsel: Add/use accessor for tp_format
> >   perf evsel: Allow evsel__newtp without libtraceevent
> >   perf tests: Enable tests disabled due to tracepoint parsing
>
> After applying this series, I'm seeing some test failures.  But I don't
> understand why it affects non-tracepoint events though.
>
>   $ sudo ./perf test -v pipe
>   --- start ---
>   test child forked, pid 3036123
>    1bde35-1bdecc l noploop
>   perf does have symbol 'noploop'
>
>   Record+report pipe test
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.210 MB - ]
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.517 MB - ]
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.516 MB - ]
>   Record+report pipe test [Success]
>
>   Inject -B build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>
>   Inject -b build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>
>   Inject --buildid-all build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>
>   Inject --mmap2-buildid-all build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>   ---- end(-1) ----
>    84: perf pipe recording and injection test                          : =
FAILED!
>
>   $ sudo ./perf test -v Zstd
>   --- start ---
>   test child forked, pid 3036097
>   Collecting compressed record file:
>   500+0 records in
>   500+0 records out
>   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, compress=
ed (original 0.004 MB, ratio is 3.324) ]
>   Checking compressed events stats:
>   Couldn't decompress data
>   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permitted]
>   Error:
>   failed to process sample
>   ---- end(-1) ----
>    86: Zstd perf.data compression/decompression                        : =
FAILED!
>
> Thanks,
> Namhyung

I'm not able to reproduce:
```
$ git log --oneline |head
a59bca6eb0a6 perf test: Add a runs-per-test flag
0d0c002eb45c perf tests: Enable tests disabled due to tracepoint parsing
4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceevent
7f57057c7884 perf evsel: Add/use accessor for tp_format
c27d357d2d4c perf trace-event: Always build trace-event-info.c
20bf7a2cd68a perf trace-event: Constify print arguments
f18b07ee2af1 tool api fs: Correctly encode errno for read/write open failur=
es
...
$ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
```
Similarly not as root or if runs-per-test is 100.

Agreed that the changes are for tracepoints and these tests aren't for
tracepoints, so an interaction wouldn't be expected. If you have a
reliable reproduction perhaps you can bisect it.

Thanks,
Ian
