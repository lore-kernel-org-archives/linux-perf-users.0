Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6E1F4181
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037357; cv=none; b=LB5nhRpzI1VHzID2sT0sTzWLGEbzUAPXfLc58mITs9ttf+mPiHjO2su4sKpmPX07IYeCBojmLtIedIG//5NwiP0xUjwoXkYdMZG+RZFRzUNwFctVgO9XUnnVlmS3TO8cNUz7SYyFpIpq6TFIpPtQQ9zmjDMeacGUfKC1yHc/N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037357; c=relaxed/simple;
	bh=J1k9UOU9t2vj5G2Miybcyl4KTUi8RAuMeOfnz5qb040=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJbrLdeILhH8aWTrn+AAYuCtHzz4W/jHN2Zk7DGScDQT5fJXddsIY8q+x2BJm4FpaYeohxlt6acVvZQhI007MRB6Mr6k4ub+Q8ybMe6dfYSTx7CE7HY6v5ridpFfZPNFwJL2PqtAe0vXY1Kz/0Whf522gB8Ma/0IHX4qX6dmWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aACFid5/; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aACFid5/"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so14057055e9.2
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 23:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773037354; x=1773642154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLGw6ZON/rxrjKmR009dp4Y/2IkAESkky6tFW0VcKuo=;
        b=aACFid5/nYaZfvUlfhGfQTdP0yp1SMp2dzbaIfGLmKB52ipttQh+V0iidfwpanvdhF
         oj9UWl4h0oUS/cpWpfdurCymGTm04WeQJvawo9XsUsaqzMDAakEarMPLnm7nv+1q5JZk
         d0r9lIqmX2qXI7TZGgcj5b1FAB9YIJ2bT2yBEn/GjenAQ47QR5CHq8TCqJQKi47lX3J+
         4RJ1faZoQGrdlPpGc15AQBLhncVPm4+SNho51tVsdhLb7uLUMl7JJXYT+jCVXkIDNAbk
         gmvmjcKn1xZJyaHuSxaF+k14gzLYoJFuxV5DaMw3WBoruhKUAi19e4GyHX6Qb8V2XgkK
         cQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037354; x=1773642154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLGw6ZON/rxrjKmR009dp4Y/2IkAESkky6tFW0VcKuo=;
        b=UW5jHKGFrNbw3W+/GeNyS0pUfeJE/LPwHN/eaiLir6wE3ULjJK1hIYtT/SArDEo14z
         qlfO7ehuhVS7rixVi6z657bxwC2C36UhHtc5TKSkuy8SrEg3PR2fb8RMo69vXHDYc2ki
         Nl1igaV7u3I14rZ+GLmkUNRXoG6NzEHLFX2kXYI7xQAcBpu8GvUoByxakmDPgH4b+NZT
         Tox1hphl/sUTWmLSp/AEdTxFGKrRzCvm72SZS4H1MQ+NdEbZp+Odd7M2Rvb5U3EwFOSw
         Xbem5KzROTheR1I50a1T9Iwb76uFiewONBsQmODg5Kt1HH0ufeFCp4HYK01dDnXmIPLE
         Eekg==
X-Forwarded-Encrypted: i=1; AJvYcCUEhlc7ihd85O4vnCylBigchQAaPkKkcZKoHnatwCBtTjI+erYxdfU9J4rzCcW0QLAQHVLjXJ05aQLFSdBJt0I4@vger.kernel.org
X-Gm-Message-State: AOJu0YzLANLyzLTL3sdVSIpXTa3w32ZQ2LZVrbbeLt+LtW8Vo3FmWDEX
	M42dSp5nHFsf0Xs+xX+Owq50gSeDsi8pLAlhVER9yG/zg1LD3B3WUD76
X-Gm-Gg: ATEYQzx9vo/Rz36fLGuGKMzeBdKTzGLETqjvmPNDjIrgOuDmd9fJIWrg5sGuMD/dGUC
	HISVH3jERkeD9U3SC9iH3zc34JvNUxbNRDHaKLEHEbgJww64p1/TqG/plxsnnSaqkCR5h9fYH4l
	OPCcvotH9DncYELEG3hfxV9zf2WlhhYrGjN+aHRUQZUe47v2FSwGIk/BG0kn5ICqbC0fkbU3Ca/
	MymWYSkHzX958qbrWIe6bRY//XD7Am4k8h1T/ImDUzqMoAvrho40hIg5fazcfx/jW1qx9fwgvjw
	O2P1nqA9xkLUfotjNGmXjQMAbmx/jegReKiQ0TQE26Tt9yW9Zfrc/JTB+O5iAfuDf30imURA4ch
	L8oIim2VoOf9ukomVq7rH9INQaB5u4ue538Kdnal7sEYJNpKu6zF7OssRz8Rp+9dOQ0/5aeIhet
	AXGj0U1KMIFXAT/gIyXSiRylquyLqA787Q6YxjeGftwMXfdZ0Uml1FbBSPTikK
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-4853dfc073cmr12575155e9.21.1773037354166;
        Sun, 08 Mar 2026 23:22:34 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm85442615e9.8.2026.03.08.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:22:33 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] possible deadlock in refcount_dec_and_mutex_lock (2)
Date: Mon,  9 Mar 2026 14:22:23 +0800
Message-Id: <20260309062223.1953399-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69abcb61.050a0220.13f275.0040.GAE@google.com>
References: <69abcb61.050a0220.13f275.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..e5ce03ce926d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7485,9 +7485,12 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 */
 		ret = map_range(event->rb, vma);
 		if (ret)
-			perf_mmap_close(vma);
+			goto out_close;
 	}
+	return 0;
 
+out_close:
+	perf_mmap_close(vma);
 	return ret;
 }
 
