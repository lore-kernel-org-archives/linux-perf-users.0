Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8618C3D
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523685; cv=none; b=uZtzFulWCatjotQC51wx0LQaw+Ox4R8GVVhH0Rt4xE8We+UkLcBk/A73HTyojzTFTi3dz6kFMEg4Sjz05G9lmddSZG8eUZpU3t6yyqqDVuoIt6LnfCvhqqe6wA23bWMWbo814YpweWqsJj7lnsPsQy4WHRW0upVB1it9FmYUNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523685; c=relaxed/simple;
	bh=TXbtAZ78VlYEPkq5bQeQqXfNd0zldDdkfJRq7Lt8DSQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=cKE5yEYmwC+j3qhIdNH5ERfVgIyrgBI2KCg+wOrLBmB31AiFdt7ZQxpipf/S9FpiDJINjhMCnP1cWm49NX1OVA4mK7Cse1dGsn1fAJZIhvytBTlQOmJiUNXPrbfwiprEhpyt7sCKNYkoCHZFHmPtoW1FmcyI9XAu+/dOc6Qvw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJgMPg86; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJgMPg86"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-699c81a261eso123970457b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723523683; x=1724128483; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsOsYbtJ24MSH9u5MSn/Posi4hFu1AvbaINA/C3HeDU=;
        b=UJgMPg868uS6z3I+HS9kWdsdv1qXXkoAWW1ByfzmER88Ad2k1qw1dyVXS3vS6zOs85
         rJWKO90r7DbClwen+jmnFeI2n0NugeMBgzg2lDX0D+WtvhxhacdQT6ltklgvXiM9MTjo
         PYP/7e5m71wknY1w2/Gs8L5UEgsOVI0MAoUeLY/z+EjCtIQZDVEmDhJ6vcY99lWSJk5J
         CXjSD7/Kr68YyD2v9rmPLDinv0coplMlZBkAqbPeYRCpuVRvZT88IDbknlEEfnA/XR5+
         6dexuHFgvesQO1+wwdN993oBHbNPhmeM0C0ISRgvRXqrwJ7l3RmVs/6h8HwN4vDLtgZy
         3vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723523683; x=1724128483;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsOsYbtJ24MSH9u5MSn/Posi4hFu1AvbaINA/C3HeDU=;
        b=X2N/z0dtkcxI3USKOKiGRUrZcIi51OabRFYGGBiriP+b+cir6OfsFhU339pYo+1aot
         cfPMIdMMJBghg4gN9UUHU2PFoBTHkr5Kfvh5Ue6h++j+SewIxFnGC7L+C6l6Z2Azlm0L
         gbscJEYt0ZeRT+6cRqv6lVXJyxlWWkCe7z0M5jxJh3bGiSQJ+jPY14xiqskticrh0soE
         isC34Q7Idgnqypco1fgyIFEAEDrk+j7JxEY9HdvCkEtMpgsg9RQ3cV4UB8uABAhrrUKr
         zjr/v2QVOGMTBzI/ZnueMGTBBeWGB4RPaLeaxvG6L5ELjUH6Qo3GaeqXoGrzxx0FajZ9
         ZlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyJNSBo2qQCBEg43zeG1J0PWzhhe1MoVNEbh5KOr36fMa4bnLEwznWP0KBr97hDEIrnNEnNJDHCPG2PH4Xzco1kf9xjdwEORF6CfaFtRO67Q==
X-Gm-Message-State: AOJu0YxWGLY8OHGQ29fHrORGXLYbOB8RHk7pchnoKr8YN716tauwl06u
	9nZOH6JbCmg2DxswcXYSLOEuRi6Mz+YaVtZ3VLmJ5ZxMd6DYP8zkfvYeD0Tz176Y2q36Q2iKG9R
	qKYyZmw==
X-Google-Smtp-Source: AGHT+IFKX0XgPJ8uEeagN2xbmgV/W6qlop6h040h/mSwx5yI4uJGowwe+eMGBY52OLtI0yxzaa6gdXJKvSR/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a81:b810:0:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6a971adda3bmr1108067b3.1.1723523683272; Mon, 12 Aug 2024
 21:34:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:34:38 -0700
Message-Id: <20240813043439.933329-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1 1/2] perf build-id: Align records to 8 rather than 64 bytes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events are 8-byte aligned in perf.data files, NAME_ALIGN is 64-bytes
which is excessive given the alignment needs. Move the addition the
sizeof so that the alignment considers that the rest of the event is
4-byte aligned.

```
struct perf_record_header_build_id {
        struct perf_event_header   header;               /*     0     8 */
        pid_t                      pid;                  /*     8     4 */
        union {
                __u8               build_id[24];         /*    12    24 */
                struct {
                        __u8       data[20];             /*    12    20 */
                        __u8       size;                 /*    32     1 */
                        __u8       reserved1__;          /*    33     1 */
                        __u16      reserved2__;          /*    34     2 */
                };                                       /*    12    24 */
        };                                               /*    12    24 */
        char                       filename[];           /*    36     0 */

        /* size: 36, cachelines: 1, members: 4 */
        /* last cacheline: 36 bytes */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c         | 6 +++---
 tools/perf/util/synthetic-events.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 83a1581e8cf1..8fea17d04468 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -309,8 +309,8 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	struct perf_record_header_build_id b;
 	size_t len;
 
-	len = name_len + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
+	len = sizeof(b) + name_len + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 
 	memset(&b, 0, sizeof(b));
 	memcpy(&b.data, bid->data, bid->size);
@@ -318,7 +318,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
 	b.pid = pid;
 	b.header.misc = misc;
-	b.header.size = sizeof(b) + len;
+	b.header.size = len;
 
 	err = do_write(fd, &b, sizeof(b));
 	if (err < 0)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 5498048f56ea..a52b85bcb6b6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2236,14 +2236,14 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 
 	memset(&ev, 0, sizeof(ev));
 
-	len = dso__long_name_len(pos) + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
+	len = sizeof(ev.build_id) + dso__long_name_len(pos) + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 	ev.build_id.size = min(dso__bid(pos)->size, sizeof(dso__bid(pos)->data));
 	memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
-	ev.build_id.header.size = sizeof(ev.build_id) + len;
+	ev.build_id.header.size = len;
 	memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name_len(pos));
 
 	return process(tool, &ev, NULL, machine);
-- 
2.46.0.76.ge559c4bf1a-goog

