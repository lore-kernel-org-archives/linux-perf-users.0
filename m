Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8D38AC7D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661816; cv=none; b=PG+fFKsn/mlUBvRhDn9deVdFljtxu3UIL/ao8YT9hiU2fcYo2FvYC1AAnVdHnk+VAEMZCohnTNVa/pvg1fbF+06EaPauzycS3S+ch8ncqtn7MzhSFZvN8HC0t65gCiLPDHNstXTeJ6KvFrg5hqMgTn5oR7iWdGjwODb60CP/S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661816; c=relaxed/simple;
	bh=vrwdhNFd8/0sOqH7+n6aIHDNJzkYohXo0NvMPviS7Fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACtct9Atlm5mnkgWVPgrXixsmHKMmqROOr+pTDJv8tTPdvvuDEBTrRO6zjkaocGS6qz2FoAo6StJuZRPgPNEjDeLYkEmYeSgWCHhUPS/l+cwP/gOgQSkyzx3MXLzxTnjeF8R2ehnVU6YFpHNQQv5/NtGj2LLwGoqijVMc7pXLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJfSR59j; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJfSR59j"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1025878a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661810; x=1784266610; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYrfWoucrFcaanHpg+ikk4kznf5bhOu8R6cQuKP7/wc=;
        b=NJfSR59jZ0Ys06mHH56EFcBapmVqyiMPm6JE/6B8mXVDPF7jI8tx9s+6WSmQdDCLob
         7tHStDr8yMkejP4Sc0PCChz5eqRiF2xJM1MxMxtZb7rIH+GBeoa5uz4kpNb9WqF9eyMa
         XzbX9q4QL67Wik1dwTFcxs/k0K0ixTEUS2lt0uLN2SUZ5DR2lLbpQSXkUdVYskYN2VHa
         H1+1cp9Ti1kzlF/zvBqNeYx4njijlYK6t2aDxgfVhpfS9w2ZqhcQbbuoBdBHa/8tskCz
         Kd5ePz/BadJ3n5Wc1Ld73ksjPoZMXYH4IHcmdc+UgXqogZ0fMJW4MKWvVTID1H/ipcpq
         bGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661810; x=1784266610;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYrfWoucrFcaanHpg+ikk4kznf5bhOu8R6cQuKP7/wc=;
        b=scjB2/JbYvo9mGroueku5T46sAKZEleuZq/X009jkZhD+uI3QSNNrTCDQo8/LWpkYs
         WqeQOWBI0jSYLlOfA5hGGbKlZCHKI7VPVyeHqwnAtvKnMHob9jI/KRxftKm2cXPEurrS
         iY23GzhS8RgvewV+MskzyMBow49hHOV6vm/TrmB4C/MvnZQ5Pp6HKSKYqrkIbtK5U8Tj
         JqkNXXD7dXZYA1/IaZBpvbf1578NcfTBeOcXF/pi9tyaATklj0lQ1/mkHGGZPZShLwNd
         5QPQDrvYT7YkDz6o+sknw6slyn0AkdoboY2997Ym32Ix0tU/X4f/yLSCA9F8o9nIeW5J
         2faw==
X-Forwarded-Encrypted: i=1; AHgh+RrjccItUizj723+Bczp9MrRoPWm2WZRH8I/MtRGEzCCuaxLa7MbC0omK6JCVva0CUVQjHVGilk3x4QRinPJIyZ6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3GX2c97rVx/zYq+M69ZHpwFbr0ThpGthiZx3MSdfOhsbZnEe
	yG4fzWir6JdTqR/UrfxzkEBm/mfZlffxlGcQqyhutkjbIECMOWogXnf5qVDU1Ve8cybgYKQ64YZ
	XB9Nz5tZOBQ==
X-Received: from dleb6-n2.prod.google.com ([2002:a05:701b:4246:20b0:139:a1c3:d075])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1587:b0:3b2:86cb:929e
 with SMTP id adf61e73a8af0-3c0bd206b59mr11951265637.46.1783661810118; Thu, 09
 Jul 2026 22:36:50 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:27 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-9-irogers@google.com>
Subject: [PATCH v5 09/10] perf ui hists: Fix dso_filter reference leak and
 exit zoom cleanup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In hists_browser__zoom_map(), the active dso is assigned as a raw
pointer to hists->dso_filter without acquiring a reference using
dso__get(). This creates a potential use-after-free defect if the
underlying dso is released while the filter remains active.

Fix it by properly acquiring a reference via dso__get() when assigning
the filter, and releasing it with dso__put() when clearing it.
Additionally, since the browser stack relies on pstack__new() and deletes
it completely upon exiting, we must fully reset the persistent hists
structure by un-eliding columns and recalculating histogram filter
states for dso, thread, socket, and symbols upon exit to guarantee
 immaculate, uncorrupted state across browser tab switching.

Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 55dd1af9c81f..570d1c07ca23 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2648,13 +2648,14 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
 	if (browser->hists->dso_filter) {
 		pstack__remove(browser->pstack, &browser->hists->dso_filter);
 		perf_hpp__set_elide(HISTC_DSO, false);
+		dso__put((struct dso *)browser->hists->dso_filter);
 		browser->hists->dso_filter = NULL;
 		ui_helpline__pop();
 	} else {
 		struct dso *dso = map__dso(map);
 		ui_helpline__fpush("To zoom out press ESC or ENTER + \"Zoom out of %s DSO\"",
 				   __map__is_kernel(map) ? "the Kernel" : dso__short_name(dso));
-		browser->hists->dso_filter = dso;
+		browser->hists->dso_filter = dso__get(dso);
 		perf_hpp__set_elide(HISTC_DSO, true);
 		pstack__push(browser->pstack, &browser->hists->dso_filter);
 	}
@@ -3491,6 +3492,16 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 out_free_stack:
 	pstack__delete(browser->pstack);
 	free_popup_actions(actions, MAX_OPTIONS);
+	thread__zput(hists->thread_filter);
+	dso__put((struct dso *)hists->dso_filter);
+	hists->dso_filter = NULL;
+	hists->socket_filter = -1;
+	perf_hpp__set_elide(HISTC_DSO, false);
+	perf_hpp__set_elide(HISTC_THREAD, false);
+	perf_hpp__set_elide(HISTC_SOCKET, false);
+	hists__filter_by_dso(hists);
+	hists__filter_by_thread(hists);
+	hists__filter_by_socket(hists);
 	zfree(&hists->symbol_filter_str);
 	hists__filter_by_symbol(hists);
 out:
-- 
2.55.0.795.g602f6c329a-goog

