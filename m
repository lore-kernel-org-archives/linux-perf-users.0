Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8615B561
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685757; cv=none; b=JvgeBzxRSTM8NOeoR91eQo8CZKt0KaVncy/TIf8Cch2eZE8ji2sgGV3z0p7WO8Nll7zOlLzaDcWXpSAiyuh4VRlJ3D0EyzgvVbj6g/STPrGISvI530sQ7/tniUagWfd5gr4Dy2mRPVaaGvd1kjiFKIMQWs1NSj6KWh30KomxXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685757; c=relaxed/simple;
	bh=BXv09/LFN1ICQHkKACTJrUA/ZU2WzDzFV1Km970Ic/A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=h708arfwl+uiq6TBdSY9FpLuiwpkNHbg2nVG2i8S3sr9tZm9eRMORQ95mFu/Xi2ekvtCIQ1/G/p0XArKTZZAC4ir+osI88IViDYWNl5HT4zwpmqtPSCw9iMjKgXxcG2bbZ6llqkwbwchWYRbOImeFuF+jz9PNtG7gJdUbLRkNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UANKFHvy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UANKFHvy"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-69a0536b23aso87605787b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685755; x=1726290555; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hstFZECCLUDlqUcYiOTZJguGTSu2dQsvz/r164qnMpE=;
        b=UANKFHvy2Hy/vfrqexOUF1I5NOvUtuvHTkpAnTBZVjHotKo1eo6kmdcJdQCvUj2cW8
         gvdQp7UrFXsJ7J/S/HO5ECIsdK5MW94mOUXxc8hh1CzZm3IwfO0wClJjBmkS72yekF/5
         YGgSZ0j9G/eI10mu7TvQ4Mbz0dTe26vpSHRJfJm01/8J0vQpAO5zU6Nyxr/lwuFU8PUD
         +AGnuyfcbIO33rB0UgBxrdbvIp6Xz93KgI9P60+8o7FOTlksxLVXtimA5jiG/jXKEHnS
         Kc4He+67QjSvZW83O0MpusFv053q3+TqWNqlKT05r3EAmVhZc0XYYNzmB0TqCYZeRGzb
         7DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685755; x=1726290555;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hstFZECCLUDlqUcYiOTZJguGTSu2dQsvz/r164qnMpE=;
        b=D9BSujqem6JE0TqMdgZ6kjdZeh6O+IdtGw+MQQRxY/PD8FjM6TPdbeqiLdBOW/OXlR
         IMF6gXGkLkzvd7oBYk+Fz3y/mvzj/E5KfCwbbfMimPzru4xf84kbfnDd3x/GVhrXGH+8
         0mTQAjRzbfwFWCFsSInQrvmJysP9MoP6kJ0kK87PPyz4fluzJ/mpkdkd0sJBNLwnUBa4
         /bVuVN0Q53zy/2zz1CjRuawCM40IZvwtzvU/pRkrQn+2OoXMGgcgkMdZEdh1cXyaDZ52
         Eu4cRNJP6NJag10z1UciG2HQ79V/cRv/j/y19wpdBPOp302n4nT38nDBdrtrd2VIr/d+
         9y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLqSD/qy8N2q0/3KoIAc+BvkgRRcn23E0OT5FahuHjjWSU9HLmpIoE1/ICGFHdE5WgdTHgY/oGbtZxFTk9ufP0@vger.kernel.org
X-Gm-Message-State: AOJu0YxstjRF3z/30ar+ocYjxlyGCn+VGX5Zbani6eafXaRxoak3Mrzf
	uy25lLT6foYZfmXOqKkNiQ5NeoR3P7gpTOlueuem7B6zb8Tfd+k+kmg8euZBiBU34fGuuoX6B1U
	BrS/W5w==
X-Google-Smtp-Source: AGHT+IG5oJaUZYWopcDEnnIXdYJhIy/sCSeitouQEpUX7tKbh+Ek6ySPDIWgZ4WxN7Y8NudRskSnJjYF+jnj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:ed6:b0:6b2:7ff8:ca3 with SMTP id
 00721157ae682-6db4512bbbfmr2038657b3.4.1725685754616; Fri, 06 Sep 2024
 22:09:14 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:30 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 15/15] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..7e3cd6c5e35d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.46.0.469.g59c65b2a67-goog

