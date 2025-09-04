Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB01A9FBD;
	Thu,  4 Sep 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945364; cv=none; b=Fz6okgyhHHcOKKYv+AOaZ8Kh6W1QAcCTTeEWAC6lZMZFleFfwVCg44o9i1femvsmAcUpOnxX5AT/ie10CaQgSOtc2tNE+f5Oj8STe20k4U3m086i8Ud2ZSx/Rj8GOx9EA1gCiTf5keKCor5wesQrlOMAk9VzGS4HGP/dRkvqCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945364; c=relaxed/simple;
	bh=3124CTpWX2NmJyzDqaFaXtKC+brHOzNaUuRC4z7F+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2TnMi8sofcIR0CRpq8hFYJ0qdL8U/TNce9rbU+Nl80XCBERxGG/G6aLx5lrQuzwRafKV9gV3imezH1ip/YhTzdXT5taXLUUYVXiZg0iIgFJ6ZS27gAJVBZH8yWIFuPbxeeE+AfFqlBze5qEfa6kQ4QtS7WMn7xQDpLkG2pweOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4j3V4VV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4j3V4VV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so412832b3a.3;
        Wed, 03 Sep 2025 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945362; x=1757550162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2npOZMsLAhal6oQPysy/cOAT94aswbe5KhIEvIg4+s=;
        b=C4j3V4VVyI8nYcTazdtI6abdS9eZe1ME8HGGbTVhiQFdlgqbusno0pWmxPdyajjyFZ
         uhhy7v+hcXtOfDgWt5DMrfbZJIiCnE/N5hq7yy1BMo9uucml+cLmgy+WXB0h+V27/KQ6
         OviTF25WyU76drp/so/BlntGrUH8HJHNfbHeblFBR+AYmn6SShaZNneTnch4DZdiMy4w
         G9FtJzYmVP+i/pcX753oHE5p97SAoameQmjb9Aenmu6JIQ/X0DfvjTsuYuPh/KKvhXaH
         diDQ9rrjyivjnMZtD9v4GbjW4HKU9fkKUJl1JOUwwfIfpUSryGUXqp252tk46KL2S94F
         kvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945362; x=1757550162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2npOZMsLAhal6oQPysy/cOAT94aswbe5KhIEvIg4+s=;
        b=DGZecTYmJxyFgV9MucaXel4LQRLSwPAVIfcOZIKM1FathckiQ1DbfCjREER7WIC+xv
         jzIe/lt1KPGeyGtizdo9HNiM0NR9BSzJ7/xb6qo63OWCREUCSC4N7/LorE3jKM6zugV8
         QL7wAGoAhd6EusnyTGCqVFVK6RFN1fSDQ5q1qCnoGmASMplyK563ABd1ObLTOtEuNwOj
         RNe/f4juCkbPKCT2CewFtI2D5ryCG//ZR1Jshc2YWv457CVtF6bgngLS5uqkwJ2WHyHw
         fU2nhTBN8lyPB9+6V2zuX7LXndbeAqpTDBUkvD1EHIVefYly7Lua1VCELVxYISrty/g+
         X9rA==
X-Forwarded-Encrypted: i=1; AJvYcCU56nLJV530VHt3zcVBmKvamvVmJHsnpgGAbF1B7g5FHR9E46cF0cI1aPM8LvdH31lL6LJMlNZiGQP0VqG+VBi8@vger.kernel.org, AJvYcCXuLDwFTy3js84v1Ia+5DoGUBaAOTsOEPk8RtRVG9BCMuaPNBc8vU1QXgY2dpSvXWNAJKJTSsxA5yAkW1cB6UO6W3PT@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkOSeEF1evNKjmERPMHpt3oXOqSRQmSRQxv3/Iu3STkcDIfrW
	NeueYW9963FFyglUHO7rY4pOWeGiIisThPH5UdpaMxxA3bfqpPCcsw/Y
X-Gm-Gg: ASbGncs0cNO2+by5OiuVXIL8AbDuRrOXmaiKB3+yOr2ahnwc9GzOgzzrGU+Zxps5uRh
	uq9mGHFkHXR8Ot9Uc2HTxqED94X5tGNgZMb4WF7RrS7qr85owH4GYPq2nrh9/gDf8RPnJlzYFrP
	WFTImLMjCPRAIAvxN52InFRXc0ZMeJtAxpp/FbgQQJqlXZ32zz31IRjY3K9kZjUuIB8OJJoEtni
	qs1DbwN+KLXXNR5EfPEvA/bjaMD3/+rFbTG1wRcBBCO2zP9VvjiQujsblopRHnGJyKmulqiUWrb
	lEYw40cSKSgUlSZ2c+7GH+vhRJMq0Grkt4rYAyeVPTI1YXVAKGADhZd6L0BHVHH6hQOlFrM+2QS
	sOlJFSXpoWFtU24WyMhBBDvz/LFajpH63RqUQF8icMHSheK7DcafBYcJg+RC+XDI=
X-Google-Smtp-Source: AGHT+IFse51pKuiC/VP4GKbWvaDWcMuhZ9D45Q5y3eF7fSZGFZeaEsbe60FdXrOe2iwXwBkbBGQYEw==
X-Received: by 2002:a05:6a00:2e86:b0:772:306d:a1ed with SMTP id d2e1a72fcca58-7723e3dd39emr25528212b3a.32.1756945362315;
        Wed, 03 Sep 2025 17:22:42 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:41 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 06/18] perf/hw_breakpoint: add arch-independent hw_breakpoint_modify_local()
Date: Thu,  4 Sep 2025 08:21:03 +0800
Message-ID: <20250904002126.1514566-7-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce hw_breakpoint_modify_local() as a generic helper to modify an
existing hardware breakpoint. The function invokes
hw_breakpoint_arch_parse() and delegates the reinstall step to the
architecture via arch_reinstall_hw_breakpoint().

A weak default implementation of arch_reinstall_hw_breakpoint() is
provided, returning -EOPNOTSUPP on architectures without support.

This makes the interface arch-independent while allowing x86 (and others)
to provide their own implementation.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/hw_breakpoint.h |  1 +
 kernel/events/hw_breakpoint.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..9453b5bdb443 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -67,6 +67,7 @@ extern int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 				bool check);
 
+int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr);
 /*
  * Kernel breakpoints are not associated with any particular thread.
  */
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..ff428739f71e 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -983,6 +983,24 @@ static void hw_breakpoint_del(struct perf_event *bp, int flags)
 	arch_uninstall_hw_breakpoint(bp);
 }
 
+int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr)
+{
+	int err;
+
+	err = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
+	if (err)
+		return err;
+
+	return arch_reinstall_hw_breakpoint(bp);
+}
+EXPORT_SYMBOL(hw_breakpoint_modify_local);
+
+/* weak fallback for arches without support */
+__weak int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return -EOPNOTSUPP;
+}
+
 static void hw_breakpoint_start(struct perf_event *bp, int flags)
 {
 	bp->hw.state = 0;
-- 
2.43.0

