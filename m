Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218501E4AF;
	Tue,  1 Oct 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771361; cv=none; b=Ud910R4znD0K8/OkwRm4CEHibbushdB61qEikx3pJe6Xi/yRmlClBuZ05kOXUGKq67cUENYVHRio96KxVyGAKKoxCFXcw1+ZVvBA++Pv/DdiZ0MbkPD+SOUDo6gjS0vmC25FfrXDRDJkxj7i2ThN2T/sltbRXl3zTlxIw7Z3fBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771361; c=relaxed/simple;
	bh=ODQg0mWhetMfZ/4EvZVC+48dem76WhAqbWQ7eFGCcOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDTspfXpNV6Kv0iXGzMuidVSCYyyBuahsj1tzGqk5iZxJKi9LmvswtyR5YAzD3x+H4ZQSGS60qnVKDUgydbp/L/70MHuRBndOaSHRYtfFxabY3PBZKTJKe8ThM0vy7WwOOgCRv7agRKOP7lOdZXP60Cq68OcP72lv1HcEOLKG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Quj8Gegy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Quj8Gegy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=HUcQy
	FO2LDFoPgbfVVhyf4GkZSZvp9KxiEc1B6KmLso=; b=Quj8Gegy/0cBc+wBN+qX2
	BWXlfoJ2/gI68rTUbwjOQDg4rE9rwtR/m2SbxmkINap3gp5M8KIbqlEUxxNlzxfW
	YoQC7BChu3tJAWAKznz8dIpZrkzzQvLwHAUdS16M1XmYDv2RUKJFUOc/rPKxZHIg
	/gy1auk8NaR/JtbFCo5JtU=
Received: from fedora.. (unknown [36.5.132.7])
	by gzsmtp5 (Coremail) with SMTP id tCgvCgCXsBi7svtmPpVeAQ--.1179S2;
	Tue, 01 Oct 2024 16:28:44 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] perf/x86/intel/pt: Fix NULL pointer dereference in pt_buffer_reset_markers
Date: Tue,  1 Oct 2024 16:27:58 +0800
Message-ID: <20241001082757.111385-2-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:tCgvCgCXsBi7svtmPpVeAQ--.1179S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr48XF43GrWkJF15Zr4ruFg_yoWfZrg_JF
	n3ZFWkuF45K3sYqFyjvr43GF47uw43JF4rWr48tFW7CFn8GrWF9F9Yqa1DXrWkWa90qr97
	JF13GrWFyr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRixpn5UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQFramb7WgDGhQACsD

The buf->stop_te and buf->intr_te may be NULL, so we need to check
for NULL pointers before using them.

Fixes: 39152ee51b77 ("perf/x86/intel/pt: Get rid of reverse lookup table for ToPA")
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 arch/x86/events/intel/pt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fd4670a6694e..96bd6aedeb37 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1138,9 +1138,12 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 		buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
 	}
 
-	buf->stop_te->stop = 1;
-	buf->stop_te->intr = 1;
-	buf->intr_te->intr = 1;
+	if (buf->stop_te) {
+		buf->stop_te->stop = 1;
+		buf->stop_te->intr = 1;
+	}
+	if (buf->intr_te)
+		buf->intr_te->intr = 1;
 
 	return 0;
 }
-- 
2.46.2

