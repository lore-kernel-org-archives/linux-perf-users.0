Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68227328B53
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627764; cv=none; b=lTmuc05VnjsvfAn0x3CSMgw9p/jUgefCYKyuyOsfWadbg0TUAtdCdSiZzdvWzpL9k8YIXJ4EAV6LVYqC9N+WdahVHE8maa0nW7GZo90PCHjlhZzXBqmoZfCJzOXgZDXQ5sOM/kFp0nb9a8Juk3yGCuhWnKO0yUcvWbtq41iq1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627764; c=relaxed/simple;
	bh=72XsDyD4QhqC99XxL2NKKPs+ap/5CJLt+GafEN9+hzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MYyhSpbG2EpjPkUB16V8/04b0R/RlYMDgXYsy3P7xWnxKFtfz18+1uEheAsbH8jY4/KeMWGYMRCT/ZJiH2oayAG7Sf8ZvC+neguLWd830uS8Ok8yi2iQsU/vBtsDqBcwZsgX6LDAxWVmQgVrcblnRhLlQGW+FctJ4bhk6QIt0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrP1sPFD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrP1sPFD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f8e6a5de4so24605265ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627763; x=1769232563; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kK4WpTbjYTQ30LMox0FYXGUlgDkXshdRvemGVnSiQqs=;
        b=NrP1sPFDNLf8KZljOW9peOaBCL26dkr3UexLZGDlM5v/SCNryFX0Ln6RwyanHUGseZ
         FVBqBlH7JhuEOcx3iWbJC/PjfcrcOhtWU90ySb9TX9VbRenu+Wdk/Cx/yK9iIAHkWa66
         9viRN/QQn7yUIg1mJYoPkTtzVW6EHNWxjYmg2ORJFPPr6VW8iXndD3h9hZTNEzsjKHTt
         k3OInXqXQx5Tbt8J0UenspACFM32zTMgn300I6i+GKZPTNowK+iKDgeX4bK42fGgeGqK
         FGqE0qoBzMu5pifiaJB8hckFTs1/ZmhY/pzBan5duZGRr7Wd5YSjbTggtfXRxKnQQ8IJ
         PYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627763; x=1769232563;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kK4WpTbjYTQ30LMox0FYXGUlgDkXshdRvemGVnSiQqs=;
        b=qrvFetfMgJBbbqHPiGUusr9vcnCo81U9BmztWophcXwDRV4Q6XFsJNYQOwxqyyzSH3
         GXtfS8Eh1sxfpnbS2sT+fWVsUZJr+/srT3Xa9cc0fXiFs2sxySchtB1HkgUGf5EBmBmE
         0wTCqfNxbyRoYuVugpppYfn8Nsm5qfemRSOTfGuCh0KuoSXn/qo4KHXp2qWrcO1m/D22
         XHR/76ti96nYTFIiDC5fqWuOLfatDRdiPm+qpWKspXvWNLwirqP5EDWS7yh4U6NR09Fd
         ZvVMgGYovqa+r2qekdkNxMsXwKcMpKPHwaITQwEsekveWHKfp89WXF0p32X6jf9iwksD
         dt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwPdPYzlnH+IZgAo0TLxke+C2Tmw83kF6tjwyGiEZQ4HOzr0kMrlM8AuvScyZr/O00m0q2zSj5nTucVeTAvIqi@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+iT7nUPTnNTvaO8h51DNb/Kj+zKM9TVxBsj7bYaYrFY9ZqB2
	DhXcXMpFhl3AbbGJw/9v/KqI2TxLYbC8qfwCd/AUqmirs6dwKP8ELZYaLzqG+ZjhtURC5WVuRQC
	RBZRII0d4pw==
X-Received: from plov5.prod.google.com ([2002:a17:902:8d85:b0:29d:7778:2d65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8a:b0:2a2:f0cb:dfa2
 with SMTP id d9443c01a7336-2a71754509fmr50340175ad.13.1768627762755; Fri, 16
 Jan 2026 21:29:22 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:28 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-3-irogers@google.com>
Subject: [PATCH v1 02/23] perf dso: Extra validity checks that e_machine is valid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Better ensure a read e_machine is valid by checking the file appears
like an ELF file and the read e_machine value is less than
EM_NUM. This better avoids spurious e_machine values when looking for
an e_machine in say a thread.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 18e656712f5a..143720d1ecb1 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1236,17 +1236,28 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
 	try_to_open_dso(dso, machine);
 	fd = dso__data(dso)->fd;
 	if (fd >= 0) {
-		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
-		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
-		if (dso__needs_swap(dso) == DSO_SWAP__UNSET) {
-			unsigned char eidata;
-
-			if (pread(fd, &eidata, sizeof(eidata), EI_DATA) == sizeof(eidata))
-				dso__swap_init(dso, eidata);
+		unsigned char e_ident[EI_NIDENT];
+
+		_Static_assert(offsetof(Elf32_Ehdr, e_ident) == 0, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_ident) == 0, "Unexpected offset");
+		if (pread(fd, &e_ident, sizeof(e_ident), 0) == sizeof(e_ident) &&
+		    memcmp(e_ident, ELFMAG, SELFMAG) == 0 &&
+		    e_ident[EI_CLASS] > ELFCLASSNONE && e_ident[EI_CLASS] < ELFCLASSNUM &&
+		    e_ident[EI_DATA] > ELFDATANONE && e_ident[EI_DATA] < ELFDATANUM &&
+		    e_ident[EI_VERSION] == EV_CURRENT) {
+			_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
+			_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
+
+			if (dso__needs_swap(dso) == DSO_SWAP__UNSET)
+				dso__swap_init(dso, e_ident[EI_DATA]);
+
+			if (dso__needs_swap(dso) != DSO_SWAP__UNSET &&
+			    pread(fd, &e_machine, sizeof(e_machine), 18) == sizeof(e_machine) &&
+			    e_machine < EM_NUM)
+				e_machine = DSO__SWAP(dso, uint16_t, e_machine);
+			else
+				e_machine = EM_NONE;
 		}
-		if (dso__needs_swap(dso) != DSO_SWAP__UNSET &&
-		    pread(fd, &e_machine, sizeof(e_machine), 18) == sizeof(e_machine))
-			e_machine = DSO__SWAP(dso, uint16_t, e_machine);
 	}
 	mutex_unlock(dso__data_open_lock());
 	return e_machine;
-- 
2.52.0.457.g6b5491de43-goog

