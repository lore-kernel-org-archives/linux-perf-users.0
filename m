Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221F3A7F51
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625049; cv=none; b=KoY+kC5PYYREBDc1hyMHH8Rp0wp/trDJzXf8XZBJ01Fw3ms+bbRvDbA+5OaflD12RSRM1eFXL3BV1Zy7QSWN0nOyMuTQwg2b7E48Vao3saNhWwX1cSk3Xdfkaap92JH9tCtKXMOgIELqFESh0I9r60PIScoTGGw9+zcGQUffePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625049; c=relaxed/simple;
	bh=VP+yMPYamn1r+ox/cH6zuRG5yU8fCc1Rb5ch97Z4oX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RDSnv7VuuclVb8ezeoEd/TZGxDN0QR7FtqMgEOlZmCSye3sBCPsZNWffdj6NFQOY7pXqHwtOA/Yt11EiIfyJ3RlEwVcjf+criQ6H6fi+vOKzNnifu91hXXfSHtBOia87LuJ2epCDYnK1HsUIX7TEXZaqPqKgtx9G22gxrQek29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzIop47w; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzIop47w"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132a99125f8so7319940c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625045; x=1779229845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3cadJ00DCY4cbIT5zIV9+HXWnhIA3Uxax5tLCzTqsAM=;
        b=UzIop47w07E/V4+ut75w6JoJu1EfAfqGkJzNlPWIqNISRoOreG0ADbmySFuo++BUP4
         KXU6LSVh1wJccKLYADUVCObz9AhxBuTNPdnVz3iOvtISMakMF3S2tTh9AwE4xWcBJoBq
         ivfdycz7dHZAN1gewXOfVxM/UHBG4cJlXmghg00vlqrWRUa1kzxtS+hMJjEcXoPND1e1
         vOkHyI5V2zLy9IgexdW3/ipd8LD/ymC44UcaweZHS/pFvsl1xISuccl+19VDqn0pCgbD
         vVPmp6yubD15wzKPri6BiIcHQ/bDgaNBWr2luC/u9zoCDO+I62WTEXP78ZbGZmQ06T6E
         G6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625045; x=1779229845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cadJ00DCY4cbIT5zIV9+HXWnhIA3Uxax5tLCzTqsAM=;
        b=GvcEerh8yc0j19G6/ltAAP1SRKsn7G5znEcFfKkjUdGlZXw0yDGsKV9wjnqinGFPfi
         47/dVnyKo3gV+mf21wxoYO4EEqz47EMgfIuEy3dVViEL503Gi+8f6L2dHDwM4UBjJeRf
         F+dI9iOnwQmIT00Q3y4XMnAlROZP+mPhIlKrxGSw0OOtkI+ft5Wgg7g+wYA+ZePjClkX
         DKq1DjON8vzLz/0C8uJsrbXgZp6OW3Zr+lPzf1HWzfjdVCpZ6CAbXjbH2+GdMIX/r4me
         bTrZYZ9RJGxZ/MD/fvFhEuvFqa0ZYkss5rwuVKihrgXxTrvJE11PdCFCfiE47KBSuo3w
         q2VA==
X-Forwarded-Encrypted: i=1; AFNElJ8FzQFy9nZcpgNabEFpp9jSR9XldlSG6dNiUI6a48J+k/zPlgvixGEmGFzsOesqxMwtnZ0YFFbraxvFp6pM+7b5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wsF+UaFzdcVjyy0m7sbcsrfSnbqy/DZjXQRDUjdjNMrpBoWH
	rHGsUGWSzrDJ2IZGnktxvyxKMPi1lAnOLuuER+rVp0KbWB7MKloZWF1/Eges6SZMZm14awWo2RO
	rGxCw0xLmsA==
X-Received: from dlbsw9.prod.google.com ([2002:a05:7022:3a89:b0:12d:b26a:1571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6625:b0:12c:8e70:c33b
 with SMTP id a92af1059eb24-1342ee4231cmr579109c88.8.1778625045056; Tue, 12
 May 2026 15:30:45 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:40 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-12-irogers@google.com>
Subject: [PATCH v13 11/32] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f8be9ead43b..719b36d4eed5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -232,11 +232,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -298,7 +298,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.54.0.563.g4f69b47b94-goog

