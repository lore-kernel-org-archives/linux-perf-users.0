Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5F1A0AFC
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524197; cv=none; b=WyVR+PnnPs4onKAExPoBzYeTi+SoOUsC+p63oFJyALfyOiGbjsrhNqrr4boFgEcvIDFs2FtIoCtm76bKXJ/xWNKiS4xUq00G4XXz9RD/hUqgvarheRbgL0D3nFADxPqldVoFZ0RW/WPWFzlPG/Pm9KoswSq5jrjQqBJa9bJHs3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524197; c=relaxed/simple;
	bh=tm2qAtOdQNlYTO2ywaWXoSUkB30rmOEo3aw7bmaE1ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw0Ygu/cgNfoJAsCJMu81sBvuNEfP6p4dSPN9+/MIqzJdkcXM6/KaBAiPWlgZZE0pcbxiaBskauqIWMHKbr5Y0fFZwL8a+zU607uuFdDiG9/XcKQltE9acH+9VUO/f8NTY+QEpcum7DetWQZXnujycA9/4+JbpMBkwewtq95qP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O7DTMkp5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="O7DTMkp5"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-63186c222eeso82931167b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719524194; x=1720128994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnK5YLt2JhGzU6G905phwSviqODE09Ru0vlDtgkEIeo=;
        b=O7DTMkp5e00NNdSS6GRhyhvPvvDwY680qt4qfL7O3IqLKsm97Gloe24qRPZhDzBIgE
         js5UtTVXGerdOAPJ+lW3Tqd8HusfGIU4tbKlrhCE0KMj9h6auVVyeKz2awx7ayiLWso5
         ZIwzV139m1JjkvlgVzgWnWCqYx8F/FYLYgJdsJbbMKqeJ4dBgvtixm9KpKvelG0cjl0f
         E4FhEN/oVVPqwKe6tndyBCv0GqqNjdug54pHVlMNfqi6aA+0bX6wATrb7NV1eQtG/2OG
         rXtcth+a9BGGZV+xFeBoeAJRwDlIWX33zMwiqrwNDo0NoLpKVMtA5B851mu51DahmdG3
         p2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719524194; x=1720128994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnK5YLt2JhGzU6G905phwSviqODE09Ru0vlDtgkEIeo=;
        b=C3SujKrbNAFTQ1cIr8DJDdFpAo2I2ATQB04blHvVZZ4/OV86diLBSxXhj8WJEGFe8d
         w62iRxlyz7klD4wIlEM6c9neLBucZyecsAuClJNU9jN+49zz/3Om90C8r+syYgiD/6Tx
         EXefvOJVr9mCZTAUdmfHQbjuKryfenoi421e0JwqivXmSFuxR44pPOlEer6kK9C3+vR0
         2BtPpJtNBS2TmepbueaAAjpOEib3HtpElOZo0LA6nht3C/vjLweJiTZliOuYFirrs7YW
         gSOMCPXqdxSa53KwGJPq7WzJJUcasgM2nAam1VAVsAR5qC0hDBy07NN5TOL9rF81HDMM
         RzNw==
X-Gm-Message-State: AOJu0Yw//EBU4r2El3QluS5REEfWnRgK/MAAurbNaCbL7hfSUde5GhPV
	5EXgrMpaW8WpY5CKGVL52d53la9hFh46XxMUzMXd2dpYNvHxBVI71DeC4DKmsg5LKkZs6dgzXE4
	AwyjJtpp1ytYJljb5bDXeVxWDQrX7xRzYSjb75Nk21ZzlzmvRcm6DtR5te0rIvgPJ2pTKlPvkGh
	FUcqbIDGho+fUVDIWnXUtehjvP2IuxjoIRupgrM/nKJg57S7uFOlE3PVN6oChP
X-Google-Smtp-Source: AGHT+IEuHN7zsF1XXO6VCBRTmR+6vJjmyw3Sp+6MqTkwLAVF40y8EHrgfZrF/9bW/Ig+bhdzIqk9kQ==
X-Received: by 2002:a81:7182:0:b0:631:259b:fcac with SMTP id 00721157ae682-643ab74031fmr143144307b3.31.1719524194527;
        Thu, 27 Jun 2024 14:36:34 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-64a99c717c0sm1009467b3.2.2024.06.27.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:36:34 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] perf probe: fix missing references to maps and map in thread__find_map
Date: Thu, 27 Jun 2024 15:36:18 -0600
Message-ID: <20240627213619.718-2-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627213619.718-1-cachen@purestorage.com>
References: <20240627213619.718-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
thread__find_map() would return with al->maps being NULL when cpumode is 3
(macro PERF_RECORD_MISC_HYPERVISOR), later dereferencing on it would crash.
Fix is to add back the reference to maps and map.
---
 tools/perf/util/event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f32f9abf6344..259cb137e5bb 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -638,6 +638,8 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			!perf_host)
 			al->filtered |= (1 << HIST_FILTER__HOST);
 
+	al->maps = maps__get(maps);
+	al->map = maps__find(maps, al->addr);
 		return NULL;
 	}
 	al->maps = maps__get(maps);
-- 
2.45.2

