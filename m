Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245903;
	b=kqgMoYz215UHsXMrhW6foQD8Hwueoh/e+TBFarrj3rbUWKhYrWmk9E4/Goi0a0AdWMM2
	 gfeLKFzrL7qNWzyGKIF0sjgF8fDZL1F5uKu1b5D93wF0bXzkLJr7zYze3ZEivj0q0UaCV
	 zaODvA7AxIXaEGJAo7ZiV6+Kp7cV1Z47i5FT3Fa29AydmcEgoM3BlhC/6+37Of1oumkQo
	 ofnQlKQK0DStuSsVflQtcEQS4AqYt81otqHd0t1WVsDoZMONAUs92Tl2MBvnOoIT0AUPw
	 07Boc9jsA37zZdKb3Wqz3XGpYkr1YJMtxNo8nK9Y2J1EbI5EK6NG8/hPHcikeQBGVqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245903;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7lgONjZFiLXDtIrsldE+TvTto8O30yy17RDXFSv3FoQ=;
	b=o0EMVxlftcuq10lR34VVVPGwyFfc83DgjqDBZyfa7cIyg8DLQ/zYGJ66HP8gcYQBY+Lf
	 4VKvR08Aw2++g6J80/Az45kUJ85h6kB5MJoJF7w2dA6hhz9G5+/e2BuK+2zJvOvs8Gpyy
	 Quo6l7gW7CQIGkI4FR1eEg0dKvyBRGY3XmyD0iBNgfAbl2/WKrnhO6jJHwA13QoG/6uY7
	 /5tbD/cd2MD6phfJu/EUlMPW0p79NNZ6fL+ogwZlYOboesksYodviDv9jQyh44NW+rUfV
	 ZDb/dc/8Xv4gkVg4ANCRIScZGPXCJxy237mAMSCHwQT2feUTkeVCNuAcwLNZzHfgfbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iLD4jD7s;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B9606A325
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 17:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61B9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iLD4jD7s
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0972C1476;
	Mon,  9 Nov 2026 09:38:19 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C8EB3F673;
	Mon,  9 Nov 2026 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794245902; bh=FkTeerMLWn8diaSOkXmQ1bD8fNgfv/VqdGDACq1nSb0=;
	h=From:To:Cc:Subject:Date:From;
	b=iLD4jD7sFvk9iG+v2SBkwlR+PPM3lgUPBA3h/BwGlh3NL0CPadzvFkRL0XXF7Hdn5
	 qaWov46eCeslIKlWnVOj4G1+Y2Oad8I+a0haJhTpfXgKHZHuD2umc2FKdNJSV6P8/7
	 irqxoPO4sgjy6kUZbg+4akpqWeqdG2B4E/iEzUb4=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Sanity-check DTC discovery
Date: Mon,  9 Nov 2026 17:38:15 +0000
Message-ID: <a1abc2ce99b91db64948cfc3b639c878f896858c.1794245895.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the device isolation feature, the control registers reset to
the "all ports disabled" value and so require explicit programming
by pre-boot firmware. Apparently if firmware forgets to do this,
we can end up skipping all leaf nodes in the discovery walk due to
the CMN_CHILD_NODE_ISOLATED flag, and thus dereferencing dtc[0]
uninitialised in arm_cmn_set_state(). While this should only ever
be an "early platform bringup" kind of issue, it's not too hard to
fail a bit more politely in this case, so we may as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 4779472ecfb8..d88339ecf672 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2779,6 +2779,11 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		}
 	}
 
+	if (cmn->num_dtcs == 0) {
+		dev_err(cmn->dev, "No DTCs found! Has firmware failed to program device isolation registers?\n");
+		return -ENODEV;
+	}
+
 	/* Correct for any nodes we added or skipped */
 	cmn->num_dns = dn - cmn->dns;
 
-- 
2.54.0.dirty

