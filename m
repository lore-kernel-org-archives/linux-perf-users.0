Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EBB67D
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Jun 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991053; cv=none; b=HfULH53oAyrdSKiBZ18c/qzu754wjdjLOHLcu2uFXO8qKwEC4YevMPOntGPkZvCytzS7l/QEpAoFo+FrqKXbKHHFls9Rv4nvJ1UjvNg6d9ftE+1NZ0KNNNi4eSbsUlQynHtnjyp55OZRo7pz4dhzIOXN1z6CDkgjzULaBQTzu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991053; c=relaxed/simple;
	bh=mOHEGgNSPhdPGF+RRp4j7BBTOJHNRqU1bKNW1P5IqZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrL5ebGUwOOboZs7Fj0VHkrnzKdS4I/lH8Oro45BFzdYzdhxg2cdC1lta/G7nicK01khvZb9RXd13SBLs/KpxSO60zvkYAPPSKHwEvBVVRtxT/QvVXA4GeVYOyShfmvwitOfJpLCVf4OWPdDbwN3VX/G2xBYumgyXB1YrfqZpBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZyLsg+D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZyLsg+D"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f64ecb1766so17592205ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Jun 2024 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718991051; x=1719595851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOHEGgNSPhdPGF+RRp4j7BBTOJHNRqU1bKNW1P5IqZ4=;
        b=IZyLsg+Dc6nR0Vw8E5vVMLXrRiqZH9IX0dOZGLluW3eVUKnORS6YoHmggrQwNsQghe
         +KMXZzI+S/4caQ5b0ZWPk9ZIMNTYDljbqtOp/yG6jA2p7fJLeIrsLVChEQZ7kuc1uKeU
         /zN5GAtFApqdj5A6zTSNi6zms6lLfP4dUPsgc29flrLWi7Ei3fczihVSaeDyEnR75DTX
         4ssCSJmTQKAxBwEyLIhFedW3MSjpTl0neUnYZ9LVbakx/8fbxj/f4ZkiPhbSPMKTBunV
         EGEKBqeRzW7/Mcs0VzaWwEfZtCzz0piAJilEcRAtMdLo7k/jYLgDbZDz/gZYtwi1iqhz
         NOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718991051; x=1719595851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOHEGgNSPhdPGF+RRp4j7BBTOJHNRqU1bKNW1P5IqZ4=;
        b=ucNe1LDIhq/zNqTgT11F/f+Q4fXNVzHKzcVmLOrrlevfzjYAtPMIAt/PTBnDMvlSWO
         e0wm3zPbCOXTRVfijhw0DTfpEFNhQ4SkJkwNOImqoPXO8Q1tVx/mOt+OA+f0TM3XBKRu
         PquasZTCpiALspRYb3pYoQtfVM7duidNHOOCHd2Zndql7Cbd6DtStX2CZuheC+p23roV
         0BEIqjSD/83gKRVS+q0ITYOq4HL2T2d5s8IeN5eCa/zsCLqirFvwYgLB/Yt4TTIOCqxR
         kEQ6g3HTCCKzDyxQzJEg/grCuYgC3oXpGO7kV0cO4dxk+hK8daNOrCbdDK/m70tJGNu7
         XbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV98jjP13QhpwN/NP6EU/kivYvVkqor0zPudzUn8qgMttcWtpDGqPI884fgFexfauE41NtIankp6CoXZhT61cbli9SvN3lp+7cp0F6NuervA==
X-Gm-Message-State: AOJu0YxOj2vWstcCnU6yIx0yjbP4UGOwzBvKzVbkP87/h1iImrBr7It+
	yJkJs7tzgDQ5tA+ClcGtK+64gO221v1H+gk1SNmmEuepf1QZlbqgEnMRzw==
X-Google-Smtp-Source: AGHT+IFu8eGoKQaGIXTde5sNjhToWzTaBsGp4+M2GELmD7em0H+09OrVsnvbBMMZBOMP+CquXfzz5Q==
X-Received: by 2002:a17:903:2445:b0:1f9:cf2f:507c with SMTP id d9443c01a7336-1f9cf2f5301mr50283045ad.41.1718991051286;
        Fri, 21 Jun 2024 10:30:51 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c591bsm16560065ad.165.2024.06.21.10.30.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jun 2024 10:30:50 -0700 (PDT)
From: yskelg@gmail.com
To: namhyung@kernel.org
Cc: acme@kernel.org,
	james.clark@arm.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: Re: Perf Wiki Appears Broken
Date: Sat, 22 Jun 2024 02:22:51 +0900
Message-ID: <20240621172250.5798-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Zm5esBevamPzcrl_@google.com>
References: <Zm5esBevamPzcrl_@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

Hi,

I want to create account perf wiki and make more enhancements,
but I was not enable to making account.

This is Error message.

Error sending mail:
Failed to connect to tls://email-smtp.us-west-2.amazonaws.com:465 [SMTP: Failed to connect socket: fsockopen(): unable to connect to tls://email-smtp.us-west-2.amazonaws.com:465 (Unknown error) (code: -1, response: )]

I hope it resumes soon so I can contribute perf wiki. :)

Warm Regards,
Yunseong Kim
