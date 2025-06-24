Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A04241674
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791820; cv=none; b=Qxayc2cYxTFAzYY6ONbxD5Zs7jiyZwxTchZR0s5gupft/uyeTuHhyvVuGtWmnJrsQMK/IwIpT1kTnKRP/8E3r6E7Z2vuQyZHKmRYzXDWGba77JI9cADqijC7HvR9amnSq1SBQuceGm8G/l//t/oren5MoyDfs2Givobt8A9kuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791820; c=relaxed/simple;
	bh=3tgl5xNUFacWr4ywDmbYp2bm4KueiDTCnUjsw04koYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a311zzs9Jhl2N8ggIP27kt6CBjKdp24uyW7/E+bakTatWp1q8QeQXeXc2k+4rr6WEb9UhW4IKggOtQep4Sj+In11/S6mRH4TVfNfWdF5axrfc+PY79sKl5L/Ob1LVap1olv+etCq5gcg3IUsX0JLZxvtbgQBBn895YVfHLr06+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHFFCUfK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHFFCUfK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so4297167a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750791818; x=1751396618; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03XNXmHms+qeob4wdysyvHMz+S3X0yXNsMANvIhS/98=;
        b=FHFFCUfKqk98KhFheiM16jdT5nDSegYhqqkeTXDTyY4eNZEfclClbyncLGYZwCbFpf
         aQhLdRWos+fs0Kj11BxgUBD/086t7/g+xwV7wCGx1FjLS4FHybn2rQg6ocPXhIZI/Lv5
         2QBVU1ErnVvJxmHRI2YyWN+wSJ4tGJirUo+ohgD3xhjDVFrnpHINkPTqL5t+hDtQq7rX
         XWuiIwqzyu1IAajvM2DgSjCdNr+fe5Z2yTiw8M/rVhIDPDSUiFpKHk1fo9jAu8ewMXFz
         sh9Tz1CWkEGsVReanoJO5nCZQUZajcrp14sEwkNhQnyn1VB1rRixhZZ1RGTdl8G3yrHf
         f2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791818; x=1751396618;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03XNXmHms+qeob4wdysyvHMz+S3X0yXNsMANvIhS/98=;
        b=tOVt7aZa3rdvnGE2AYmIU6tydROszDHVlAR6e6ctKeyOtboZ26ppxZz9/m0b5CF9Zo
         qj2ccxJkGJVXgkTZF02ToeGLs5JX1Z7cSf60/fzz+nyP/k+PEaE6bFpbha8ZFavDmTNC
         L9jIviaSWgLrDsPMIzZRy8jRTiFFH4+w+t8Tiq/+0Z5OTC5B4iXlrQ2iLm6TbXlyC+4d
         BMM0ZsKsxEpQuwq5QBPuCdkJb69IKMv3Wgh7eJwVVs2tVn6aXoivdELFI6u8vBtnRWoA
         J/2W2NcxVgK5jvxJpzK8pvaSC9afVnFPbSTHkoVuzvYzjwgxSRpQg0COqnoZDTSs7aPu
         jM8w==
X-Forwarded-Encrypted: i=1; AJvYcCXVacWyckZe1tEEw9ordbNR1qLY+M0KvYXciOPMC8C/uRDYZ7gMS2BTqQg8ctZ2FdQ1PJItJX76se3mrh2i9xG6@vger.kernel.org
X-Gm-Message-State: AOJu0YyGu2wuLx1OUGbuTq2xogg/GgHu+v/cKDY+KkcVCq2wssuGYw8r
	LEfx+H/FXKXTlfj/XWbMiXslP+HcsLzW6oB1S9mOZ2hakJNvycxiAAre6v/pQNsR4TTlODPTK+t
	ns9HQuh3raw==
X-Google-Smtp-Source: AGHT+IHPdOePcyO4aRvWDhy29wCjuehy2KtmqTe6eCZKwMPh45qJNuyJpcPz7B7VpggSzv/oBYMA2XI9jPSd
X-Received: from pjbqn8.prod.google.com ([2002:a17:90b:3d48:b0:312:2b3:7143])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e41:b0:313:33ca:3b8b
 with SMTP id 98e67ed59e1d1-315f26189bcmr19867a91.9.1750791818291; Tue, 24 Jun
 2025 12:03:38 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:03:24 -0700
In-Reply-To: <20250624190326.2038704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624190326.2038704-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624190326.2038704-5-irogers@google.com>
Subject: [PATCH v1 4/5] perf dso: With ref count checking, avoid dso_data
 holding dso live
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the dso_data embedded in a dso there is a reference counted
pointer to the dso rather than using container_of with reference count
checking. This data can hold the dso live meaning that no dso__put
ever deletes it. Add a check for this case and close the dso_data when
it happens. There isn't an infinite loop as the dso_data clears the
file descriptor prior to putting on the dso.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 057fcf4225ac..c6c1637e098c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1612,6 +1612,10 @@ struct dso *dso__get(struct dso *dso)
 
 void dso__put(struct dso *dso)
 {
+#ifdef REFCNT_CHECKING
+	if (dso && dso__data(dso) && refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
+		dso__data_close(dso);
+#endif
 	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
 		dso__delete(dso);
 	else
-- 
2.50.0.714.g196bf9f422-goog

