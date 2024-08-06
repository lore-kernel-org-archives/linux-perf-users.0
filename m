Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955DF9CF
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909433; cv=none; b=mqFd7xvU6MijLWHq6Zr6SulkhNRuSTW1iY8iumhQzSfMAa97VITyDtUOCE/I78Blnv5UzPpbJYYjSNbERX2AOSf8xRETgZy3+yPBvFYFmzWIz284+Epv652/5Y4yuFn1fIFuj+IJ1yv4Kco5iVqHTuIQCZZTYMjN/b6UeLvOM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909433; c=relaxed/simple;
	bh=qmjwWQ6QasKjrkVUxCzo9BcRTbn5iMp89oLmum3d2Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2ao680Dezw6K4vuzXE2Gaa8uCWbrxQpV+KWfmeazTugDU1miOB2+hlktPOdzxwoyifXI+PWoJBKNO0fuCK+x/RhHvt6k9syTnYC2Ow8AGqez4Kag8IHmQK8Oozyfw3MAhIvv4J/YrnkwnJNBVpSRvMW1P1lOYIoD0IiLBv3GhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UR0WAKVJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UR0WAKVJ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc56fd4de1so2559955ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 18:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722909431; x=1723514231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNbH2l+f98EFaxyweVh/dPqISWyY0AP+f1WHA/sTSok=;
        b=UR0WAKVJ/We4USVgtTA8DAXtu9RZyoAV9PX0QKb2wSjD8pv2YnilQyTvtOUKAXJAhh
         srQFpjJZ17kB4eeZMS7pN+5cDQ8zUtyqA1azbAffA2qytC6lJksHo0Q1CW/Uea0oxfdT
         1H0g0qKXPgcMRFSaAPKi3rE2iDb36kxt0LxwRM/il8CcRtdyaWMbJINyGca2tx9nZGCX
         hZMCwkfTmnunUc6yrBxM5aW33dt72zj5F4JIZiSSiGiKchZPOCuLOMTJYJ0bXA/WaYix
         V0j8KYNDFbX3jsvnViWhW2RgRFqIgiD5hBn7euOc5Fa07DUMYqNWUMWkoF/JJZ95qs5e
         FiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909431; x=1723514231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNbH2l+f98EFaxyweVh/dPqISWyY0AP+f1WHA/sTSok=;
        b=Kf9TuHLtPolNF6SI9yYzJ0XFUh/Py3ag/YQRhCj1Bo1bY104c07+KXILfRle0j3j8C
         RBfBy7Uqks1lEHx+Tq7VtPUU2kCe3Fr03H2QnF9hLRbDCadjfulZpT2eBxTNgp4EqITl
         rWF7SaPhP5evknDEDLUGsx//qAa879pE8ZE5lgF4m3ErSSy05d2P0mAS3/Pk/bS15uDE
         W5OTN5kQtDW+6FmhAKY1NAxplF1JqwkSHaoMACFYGNqE9+xIVV3DeWkoVbU1odIj8P0H
         kvVfI4kA5KyzUlOCKe9+qsNXQRykp2l9O69ltuHTjTQyjeYcd8vJ0incOzdcDtbYzaUB
         +oTA==
X-Forwarded-Encrypted: i=1; AJvYcCWfVysLsD8JkeaKbLkukrYuIHZsUP9C4M0iwBURCM5FhNhdvD7a76nlMoKZved9/pHs1alzVdBM7lQxm5uscknm@vger.kernel.org
X-Gm-Message-State: AOJu0YxQC5v0vX+8KoL9vElAocqkb2Cg5SKDpivEZZ1GhVWDYd59cp27
	AvLiacMPGsR0natsTO5+A+hvs0ASI33vRbmWsGqN+COIRDnDvB6lZZo/GaXPHdurLsbkOT9p2SS
	B
X-Google-Smtp-Source: AGHT+IH+NAgt5RGJPsxRWyM2LY2HdYVr5vLtBqHS1AuItEYySLf9oxzb1hg/HtnL1pYaofvNDkUQVw==
X-Received: by 2002:a17:903:1209:b0:1f4:a04e:8713 with SMTP id d9443c01a7336-1ff57f062b9mr246030095ad.28.1722909431538;
        Mon, 05 Aug 2024 18:57:11 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917496fsm75509455ad.182.2024.08.05.18.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:57:10 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 0/2] perf sched timehist: Add --show-prio & --prio option
Date: Tue,  6 Aug 2024 09:56:59 +0800
Message-Id: <20240806015701.1309833-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds --show-prio and --prio to show and filter task priorities.
Sometimes may only be interested in the scheduling of certain tasks
(such as RT tasks). Support for analyzing events of tasks with given priority(ies)
only.

Both options are disabled by default, consistent with the original behavior.

Yang Jihong (2):
  perf sched timehist: Add --show-prio option
  perf sched timehist: Add --prio option

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 163 +++++++++++++++++++++++-
 2 files changed, 162 insertions(+), 7 deletions(-)

-- 
2.25.1

