Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C111C32EF
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167862; cv=none; b=eWmXm/IJhCzraquUiZvQ/ytyvR+szeep6cGB3iiPdVdgejMgdD/Eq+07L3jpKrwN9MqxxYyzZMaLzTkomqU4A82rysazvULcRNMfppspfpkrPYZLls95hlQQHhVDcSnCIatjrxJAXMbjEoEANOpQAa0AHLX/lLaDA8/V2H78HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167862; c=relaxed/simple;
	bh=RJ5W/zYraCvAw7Bh0lRAuAFUwylWc/Oc84BXyHNcF/Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nozS89m69Crz/zy1d6UODQhd91GDwaYG7glrrkiWQNKlm0ShGWuHHXMXiYkk2IR5fRs5vPvBbp3h3/MIVrpqU68qJ5EFEzEwyaCgLWRChKb/vBrjlY04XMNbaYg5HPkguTM9Q8ufT8ouALU9ZLh3/sH1RzyGCfUut2SmeaOhHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JACBFEpB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JACBFEpB"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ce191f74fso2273326276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167859; x=1726772659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrPXDAQds8GhpE0L2UtYrjlHtGIsSgYNHNY+b4ghkKA=;
        b=JACBFEpBFW5ukfyelPD/vHiLplxULCLgoL+ZG7FjnIcdYcP900G42/ZRvodmgXohFD
         A/P3RxEOBrSqGt54oX/n6hGR3uspNRZmn9IwYO82iIiNsDqbCJxEaA7gEfqio+oWEkpf
         ePHdv+u6lV8xcJcoT2IMd9XUOz2W47zTWXOtz5aCysgrASVA5iBpJ1dZ7OiOy3kasPQD
         uZyfgIMPaM+fkzb2LEvmCDZ/3erJDnEs1lCRFjyBuHt8P3XHBom6btmMfegoQE2GwrQP
         qKBnWPK/aDD31yDsA6iIHPn3qEed6qpnqPBGvM4H5hLzBfxD/ggKmMb+ecFQqLTTWQKl
         ifwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167859; x=1726772659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrPXDAQds8GhpE0L2UtYrjlHtGIsSgYNHNY+b4ghkKA=;
        b=oqHI4fJ0FyyrIOz0NXzude93siuzSjwwBuz6oqCupOHQVeK9c9Dw1aatC8ffeudJxb
         KOsJ4x5bTvWpvaR/6UkZlPBrNgyzzn67EKuVy7VgvIZRsbP4++Ptn4V+IXiiddmhp37j
         mMPYv3KGFIlAoTM7vdeeYa/3pyLypy1p+/YxYVhRZT2fmO2Ne6Q3Vhd4l+zBJaKxl3g1
         i4xXJ+8R1pjR7QOHqBOLHRRmlfI+gg/3y0RU4fhYxHr0LTX7evNFSyj42O+uMagAUoxR
         5Vo1npfxxZPSyQn7vHofLqp89dTGVN+l8idSdCX+pRNhGYRLy9FNxLHkKEoryl2KJ2Zz
         Q00g==
X-Forwarded-Encrypted: i=1; AJvYcCW4kZ51AUJLcc9MOZ7CUdH7/arq4A8zLynfUV9mWm3ze2ykU5cKiPwRwbyd6yN8q2LqS2Jlb5GozPj/arInemkB@vger.kernel.org
X-Gm-Message-State: AOJu0YzE64xWNxgNgj1gpzTezMTK18GU0LambPJ7e6Xlc7ARJ9kTxTJz
	TMkc1qghX8TB34j8zi53Nkph2zqxgGV7yjjE4rJydSlzJCUPlBldxJrAHsdPLXUvxeyaMP5jLpd
	qTvoHxA==
X-Google-Smtp-Source: AGHT+IHsr4g0/u3/EUs9RZtOfqnhRbYbbDoqivzh2XAZyTREatuXZND1Qt3I55ORB/+O5w6/zYZkDZX/sbon
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a25:bfcd:0:b0:e0b:cce3:45c7 with SMTP id
 3f1490d57ef6-e1d9dc5f6bcmr4760276.9.1726167859376; Thu, 12 Sep 2024 12:04:19
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:40 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 13/13] perf docs: Document tool and hwmon events
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
2.46.0.662.g92d0881bb0-goog

