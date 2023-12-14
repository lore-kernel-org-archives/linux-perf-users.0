Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342986C6CB
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Dec 2023 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLnQ3exC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c32e205fcso166955e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Dec 2023 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702595756; x=1703200556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxVgHS7yw3Ew3Lu3ar2phPbL95KmoT+h72FxnQQxGgI=;
        b=YLnQ3exCD63EaJ+/TafrRELRNJVxvOdjJXp/U0D7mACGCl5v2+LETWXL0FaQmzRYF+
         RWKz6WcxMSvVqGr9U8rr+fkHxtMp6d+wfGV3+NlK0895PhskI7GmMSuaoP+oMPHf8bSa
         KGJDvv/ienHgcBoNwgUrXh64RuS9rHNa6b/v6cM81Ebv25JblrNBtSL21kkeF0roDjxR
         TA8cjPyhOZSnnq276WYVO8OJ+D8ZZ+Lt+bjMcLiglA5G4e8aYqWEAcLgBu9hWf4M9k9e
         iR4bzduoROI0WWwZp6KTmfo9u25OA+W5CK0gkmmRsT5dF2LBRgKgNxyHHaodfadsI0J+
         UUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595756; x=1703200556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxVgHS7yw3Ew3Lu3ar2phPbL95KmoT+h72FxnQQxGgI=;
        b=F5IjsibmHtIzInS3zP9na41Zvmd7XHITsN3J/fdfcYFvLJue8XyJRNQ23FQtRfUZtU
         QNQmY3cNIL7EJzjqDSv6rQ/WhSxZc67hzWK+c4DnLHUo+KItviUjaNyjGa3ADUxwI9K9
         OSC+vz/hQHPPFoNzfZUhJGyl/2+KA6hWGBHtpnk5DINhXwzye64duV6Mp2I3t59H5Qmm
         r51IVbVDQEMiMYhdFwb6EgT8WH/MbDEDl8NA5waLBZ7PxM2USSb6khO+Bd+j6YNPNWSn
         g5a6D4u2GSK97e3hydLvl20rr/FXA8Os1Cprss7o8PpRMHmej8//eWqvnNA80JCDvYtw
         EkfA==
X-Gm-Message-State: AOJu0Yz3QIg8HyZfgDFj2h3FYHT5x16wRDtSpms18pRpG5Nu4pYR0kKl
	hsjoTREDIsKZLV5Q/S/KN1FSkn0kjLRnkg==
X-Google-Smtp-Source: AGHT+IFXYofH6TZODDPI+fxxXDwc289cWs/qo3qyY/WuRqp2260mZKsbSKV8qdi1MXOmhNov6VkMxw==
X-Received: by 2002:a05:600c:1da1:b0:40c:3820:eff8 with SMTP id p33-20020a05600c1da100b0040c3820eff8mr12806552wms.3.1702595756310;
        Thu, 14 Dec 2023 15:15:56 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:5e4:1d0:6752:3cf9:29c4:bcfe])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004064e3b94afsm29163901wmp.4.2023.12.14.15.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 15:15:55 -0800 (PST)
From: trinity Pointard <trinity.pointard@gmail.com>
X-Google-Original-From: trinity Pointard <trinity@deuxfleurs.fr>
To: linux-perf-users@vger.kernel.org,
	olsajiri@gmail.com
Cc: trinity Pointard <trinity@deuxfleurs.fr>
Subject: [PATCH] fix perf-stat regression printing stat on enable/disable
Date: Fri, 15 Dec 2023 00:14:35 +0100
Message-ID: <20231214231435.508126-1-trinity@deuxfleurs.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXhN_j8UShp1JAlf@krava>
References: <ZXhN_j8UShp1JAlf@krava>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible to reproduce the issue with this script:
```
ctl_fifo=perf_ctl.fifo
mkfifo ${ctl_fifo}
exec {ctl_fd}<>${ctl_fifo}
perf stat -I 10000 --control fd:${ctl_fd} sleep 3 &
sleep 1 && echo 'disable' >&${ctl_fd}
sleep 1 && echo 'enable' >&${ctl_fd}
exec {ctl_fd}>&-
unlink ${ctl_fifo}
wait
```

Testing with 27e9769aad3c435993a2e0cd91f5d868294145d0 (perf stat:
Introduce --control fd:ctl-fd[,ack-fd] options), it prints stats 3
times. On disable, on enable (stats are mostly zeroes though), and on
end of execution.
Testing with a39b6ac3781d46ba18193c9dbb2110f31e9bffe9 (v6.7-rc5), it
prints only one time, at the end of execution.

My idea of a fix is to modify evlist__ctlfd_enable such that it and
evlist__ctlfd_process return a positive value on success, restoring
its previous behaviour.

Signed-off-by: trinity Pointard <trinity@deuxfleurs.fr>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e36da58522ef..ed7e2dec365d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2111,7 +2111,7 @@ static int evlist__ctlfd_enable(struct evlist *evlist, char *cmd_data, bool enab
 		}
 	}
 
-	return 0;
+	return 1;
 }
 
 static int evlist__ctlfd_list(struct evlist *evlist, char *cmd_data)
-- 
2.43.0

