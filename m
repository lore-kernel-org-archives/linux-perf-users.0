Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518236C9D0
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614150; cv=none; b=uAufqoDGPLZ8lECiZVczU0qGmU+CjmrVW9mvRRmgwDms1QgsJ2+ocgjbfThz6Ob8hArw1TOPbgz0076B9a7qkc4FRpgDQVwBG3uwTYOmwSlPuWBSDSQfLEt5o4XcIWPziBZDml6YWSmSshHMLi3P9EBNAzLZ/PQaXNKAw9SUo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614150; c=relaxed/simple;
	bh=PR8MNZhxCDgxVdk6JApNYOffCZu2rcwBtoxpFaVaxXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bi/n7OSRCHZ7DQu1shCqheDE4ICJTyBi90M25nM+BD6tO85I1KItZM1aPJ1F6sF5q4ECMk28d9zwk0h0NKa/netk483K1jbi57AkEsAYjKaZCcMu1NqxtkCmAwKp+dvzJ8OGMuKmZUz2vGjYC9dY08JLqXrNq4rx7g0QMHUnYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dq4jCgz8; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dq4jCgz8"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127876be621so382984c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775614148; x=1776218948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DbmMGj/vxTCtEVQGakPXINHzX2eKFA0/buM7lOEXCs=;
        b=Dq4jCgz8th7mPLuPXC+bO14eM0l8j7j7jSn8QRn291THlWt3ntCKB8ZPg+9ynvwmER
         xdV+gY36za26c3m13/21D/MmsMMbTz23Pw6uMBdRh66Tk9Rfv6mIZFKaUiFc+/UaqUSM
         zdmDefuNB0hjkvYbqw4xX3MjjD940dWp2nApNnGV1cMhDzY+A4ZmctVKuHdvv2zHdpej
         4F0x1K5f1MuZeWDH3inHBBw1wtGcrrXA3VI2mbNTqCkIWgwKKu0fZ6oh6/DKl0BYkCRp
         TXAh8fvecPcnvO+jTWp1u3t8+XbP7StfhUTKZCmSo8fsP4DLlGsjZFT/h4rDwRCdZBP5
         qOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614148; x=1776218948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DbmMGj/vxTCtEVQGakPXINHzX2eKFA0/buM7lOEXCs=;
        b=VPUTxnLy8orQzbydXMx60cTWTCDm0vXJBRQllmbshlr5S5F1WyNPD4f00d1QVR7aV4
         AaNY6EnNx6Ppw8YWxfhYU2KYVOdziJC59ikuUpYscGQKnZhmOtn7RO3FDQS04TduWD7B
         158x37dA9fTd1/I0ilSG9j4MhctinteQN0s+pNd8C9UDeY+8Z8RthrEQvOVdtmNg7Ukp
         t8ugYalqYvspfwPyZ7jg5OtmhiP65X3n7UyDgeiSU2Tx0pug79E5QK6SLwvmSfLfqtvT
         JmfEaaX1t3K+D2mN9Do4a9VfyKwn+I8ARuJWIY5FNZpg+Mx2juPIhnIjvOalNLj2NUg+
         HNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwUdVEyyEk2799IlljDBnB+U61tUBR+fSQaDFHUwokmqExqS5V41C/o+sONOog3pbfsvorNp/3Hd0DFYa2gzF/@vger.kernel.org
X-Gm-Message-State: AOJu0YyLX/a5zF09l38m0/S4IdFTrd97PZYmMJ6hBXCSMLuc8P01CM5/
	r186mbiVJRWkrODti3cSKPSOPUbw2/VK8fjxUEE66wishuI815zZdorHOJO+X3cWMybgwtinVaX
	gMfWxsQBAaw==
X-Received: from dlea1-n2.prod.google.com ([2002:a05:701b:4201:20b0:128:d754:39d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1284:b0:128:cf41:d6e4
 with SMTP id a92af1059eb24-12bf0899182mr9071834c88.21.1775614147244; Tue, 07
 Apr 2026 19:09:07 -0700 (PDT)
Date: Tue,  7 Apr 2026 19:08:38 -0700
In-Reply-To: <20260408020838.166906-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVqaqNo1VyGPWhZ+DvEv+oRUU=sMtBtpFbm4D-sJb-JNA@mail.gmail.com>
 <20260408020838.166906-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408020838.166906-3-irogers@google.com>
Subject: [PATCH v3 3/3] perf maps: Fix copy_from that can break sorted by name order
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ctshao@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When an parent is copied into a child the name array is populated in
address not name order. Make sure the name array isn't flagged as sorted.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index b44bc41f51f3..81a97ac34077 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1081,16 +1081,9 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 				map__put(new);
 		}
 		maps__set_maps_by_address_sorted(dest, maps__maps_by_address_sorted(parent));
-		if (!err) {
-			RC_CHK_ACCESS(dest)->last_search_by_name_idx =
-				RC_CHK_ACCESS(parent)->last_search_by_name_idx;
-			maps__set_maps_by_name_sorted(dest,
-						dest_maps_by_name &&
-						maps__maps_by_name_sorted(parent));
-		} else {
-			RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
-			maps__set_maps_by_name_sorted(dest, false);
-		}
+		RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
+		/* Values were copied into the name array in address order. */
+		maps__set_maps_by_name_sorted(dest, false);
 	} else {
 		/* Unexpected copying to a maps containing entries. */
 		for (unsigned int i = 0; !err && i < n; i++) {
-- 
2.53.0.1213.gd9a14994de-goog

