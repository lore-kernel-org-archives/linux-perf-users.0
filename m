Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8E3E8346
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866759; cv=none; b=sPkFwYs17itNOK6+5j1iPKbSRyvIFhecWCjyviVqC/mx8mdIJRJ6Ep8IFE5QlQW11QMONNEoXYO24FW2HihgG0KBDuuBqWql9hiCaXy3OLx9xp8heaqCCG6VlCg1tWdgmzy2X+FhubBmo75pqeqsnwoRVc46fXqvF9FlTx0spjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866759; c=relaxed/simple;
	bh=l5QKav5wmqSVNvurZfB75hgd7Q4yiRfMQ7JC8EnR+0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncZa4MrnDTDNLO7cL6gsIXM31b3INDmYPqjqQxM5C5OLxGdCoWWPL9H1+EEphMEx11O3NLqRYPsxynvHeWDtfnJ/1bGADZSYBm94OMygq1a1Xa9lQHTTtJT9kByumCKtN7BV9rVxWfz+woft1OFOF5GDRc+FVtjPyzoRzjatCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oU1lW+Ws; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oU1lW+Ws"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353bfdbf99so230861c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866757; x=1779471557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=oU1lW+Ws5YBcwmQ83/HvJl7AXXDCP6vLKZ+Rye6qwmaeEobu5qWrEcPZBM+YghLTzI
         suMqv2aZTVpIoRavC8dTRXkIga6eI+NvLJgIC4931gEtFJ2f4ZAB8Ev+SNNmQgUxNnX4
         vDf8raCz5uSCIsJuujxJmpoMltrNA2VUdxDgiSWfvOuPgDag5oiguDwv2nfAlbLzAIIs
         1ku3NAcOPsC5Nr4hP9Uwz8fRQJ0dXRZOBzk2nNMRjJfEi7n8agrnaqn78Pjy1mFzlv9f
         aGQ9rW0BL+RzAnZuAEe0VYKxTj2uauKIfwXLHk7eZkKAPe+lwcYklWtSJLgbcwBkwDoh
         WTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866757; x=1779471557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=cTFJFCiI8G0RINuUM/Boy4pBgtf7sdTY89cAb+ZS5fEJNWse1hsYmzP0sj5bvGaLhR
         LmTZtchPZxl5VHq8noO83IS3UVDvGhjWUs2OW0xRqdpx/q7nlcRT6TkJ7cqeH3WT+ahM
         FER6KhTVdaBIsGZyLwnD/zia/XLrTQn9JC/D4KA8c4XQwOslfEseZej4ahda20WsvynB
         jaPnJ/9sIzYs/ipmx5KltMR0OHPUZlrpEJqIc3K3SAi69fOa8L7eEtY1uPJAKBUMLVf2
         7xN5lsMD//cdoWKy08m66H5uSkS7TZma6M33YIgkPNR/d5Sy3MrDHRh79SICbPi7n2w2
         TDcw==
X-Forwarded-Encrypted: i=1; AFNElJ9IPlxmAn+lRDRnUB7mhruORWYuuD28P8TPzS7kKVF8G9HMg1X67Xsjl1DgFUsKmd6zNHbdg8ftqIhdlZF0JOw5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/3MAY3Xxbe0CLT+IEeBTlPZt1YRPs9USHLh4ekE2ciLs9J7P
	nVfvSpnWxDH5RGNCpTP2kTCDa2OLgiSaIGqm1In7UxiR4TFLu0oeRau59wk4L7DYebtisw84vdG
	te4pPeH7Sig==
X-Received: from dlbui2.prod.google.com ([2002:a05:7022:3d02:b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fb09:b0:12a:72af:83d1
 with SMTP id a92af1059eb24-135046255femr2542223c88.11.1778866756863; Fri, 15
 May 2026 10:39:16 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:45 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-9-irogers@google.com>
Subject: [PATCH v4 08/14] perf build: Move libsymbol dependency out of prepare step
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

The prepare step is a large serialization point before parallel
sub-makes build the perf tool. The libsymbol headers are used in the
bench and util libraries. Move the libsymbol dependency out of the
prepare step and into the dependencies for those targets to avoid it
being a source of serialization in the prepare step.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 876065a02de6..96a68723109f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBSYMBOL) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBSYMBOL)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
-	$(LIBSUBCMD) \
-	$(LIBSYMBOL)
+	$(LIBSUBCMD)
 
 ifdef LIBBPF_STATIC
 prepare: $(LIBBPF)
-- 
2.54.0.563.g4f69b47b94-goog

