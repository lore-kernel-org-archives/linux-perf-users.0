Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87745977
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Apr 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017794; cv=none; b=Saxce7sUX90nbF+stw7KzRftFFv0vlPNxlf7KUQtfHhLBcgh7PYX79Tbt9lzoOx7LRGJSsOtUDF9l1Qaximo8/ruQR3Z2qi79MHNkMLsn3bSKMWICRJtZ/xzIo8ZO5Un8CoJkZld/YRL7SQt7L/miEaMsAxlDTGA2glP7J8PUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017794; c=relaxed/simple;
	bh=dtcXlJarwcAh738y46KpVauFfDZzs+CPG9CoF31We34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFWv4YxRO06WsCMiYscKcwC9KEo+3CIacVAj5ik1W2wryxrbzvXjMJzPwCNnGl/38Nx0s/tc35ji+aDdp53AGNUHZAd+1p4xiMPIIDEJ+GfkmP0IHQtciQZkmZShvBY34UI0Yq7Hf1ZT+s3E7s8ZmBUpLh7eZjFPbDK7ewMj/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=Nu2bsjxV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Nu2bsjxV"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1777669276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Apr 2024 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1713017791; x=1713622591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlVoXtYOUZbgedQGH68sMA7/TKjo/LarRqMzSUO0lI8=;
        b=Nu2bsjxVqTg/ziqOueDSd91dHssNR9yH/ZebKAPCUg2QODI4KC4Pzbzw9M6/uLPM0e
         W7YTVxWBO4rp2+nsL5PGCmxHGjkTA0u61oCYTsTfNj2Rhi3L959+2Im1yZsJlbfNDrOa
         PMsGYXn2p7DiTgi3Rc19eo26VE5+z30pxR1QiFGKcmkoRLo0fYtfA+Fnhb90j6Q2gslY
         zjbRoZ+kYS6oPWwPZwXLgceEXIqownbnI2Dh/xZ/7h4I6A2jmHUG20iTO2RjNC/LHQPO
         zS9rXQbjckRziA9xewB0UoT5wFoWDXLc3htDDGW+RWD0PejiOnGqlqwl/HGFv/37Y9zQ
         4aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713017791; x=1713622591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlVoXtYOUZbgedQGH68sMA7/TKjo/LarRqMzSUO0lI8=;
        b=RrxuB7iPlKO++QzCPB3keX0eyjj2IBtKf+ChBaf3eN0pM5L/QBr1nJXvlr46NUQ/3r
         oCf+1vRImotrm7yI9KHLPg4JvyNfrRMyAZOyWZA/KSqgexEwcNViit4kg8oghKJWmlsX
         F/eDgAuku0QmOxvh+76BxliSnT78XmBHx4WCIOPE9SDWUzhuEG8RZadvKUU8e0Owad+j
         uIVCDP8Ux/3FP1jI5fAa4shMKOJqU7jx9kZcV9u1sEBPtW7Ah9Gdf1w1IvmoSeS8MIcj
         TWE8ntfoUjhYc9ZS4tsWre6wG0tB+Q/1dSzo9mWAlTr+Z4hLCBNZu5EeZZEq1zsUTFjM
         D9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/WNHT/SwVcayeG/48AZ0bDWz5rDCURE63b3dpx4g+HF8o7bT79FKltgyyd9ihmRNZnfJSS4YjziHfu06ZIlfk37B0GElrQNFmG8RNguL/KA==
X-Gm-Message-State: AOJu0YxfvFxQvoCJShKX9RPfUHsNRwP1TRrdEueN1vHGTcs7VnB71XYL
	TMdkb7DfgO1Y6aWKh7/+r3IueOXQ1nNENGXQNHDq9UCY+eqK6eo8GylXI0ZS2g==
X-Google-Smtp-Source: AGHT+IHfzpuJoLkZ5tVYHvUeMheeAQWCbrYbrG2Pq0evod13mRpefIayqHQkJwSzDH+nNCGjp5Q6RQ==
X-Received: by 2002:a25:8083:0:b0:dc6:bd4c:b119 with SMTP id n3-20020a258083000000b00dc6bd4cb119mr5325358ybk.55.1713017791674;
        Sat, 13 Apr 2024 07:16:31 -0700 (PDT)
Received: from ip-172-31-11-157.us-east-2.compute.internal (ec2-3-145-99-109.us-east-2.compute.amazonaws.com. [3.145.99.109])
        by smtp.googlemail.com with ESMTPSA id v5-20020a254805000000b00dcdb6934617sm1193349yba.62.2024.04.13.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 07:16:31 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rodgers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 1/3] perf: Move perf_event_fasync() to perf_event.h
Date: Sat, 13 Apr 2024 07:16:16 -0700
Message-Id: <20240413141618.4160-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413141618.4160-1-khuey@kylehuey.com>
References: <20240413141618.4160-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow it to be called from perf_output_wakeup().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 include/linux/perf_event.h | 8 ++++++++
 kernel/events/core.c       | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 13a2b05cc431..4924bae0a015 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1680,6 +1680,14 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
+{
+	/* only the parent has fasync state */
+	if (event->parent)
+		event = event->parent;
+	return &event->fasync;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cd88d1e89eb8..7358b11f9003 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6684,14 +6684,6 @@ static const struct file_operations perf_fops = {
  * to user-space before waking everybody up.
  */
 
-static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
-{
-	/* only the parent has fasync state */
-	if (event->parent)
-		event = event->parent;
-	return &event->fasync;
-}
-
 void perf_event_wakeup(struct perf_event *event)
 {
 	ring_buffer_wakeup(event);
-- 
2.34.1

