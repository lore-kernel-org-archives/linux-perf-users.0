Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451236;
	b=H06vgw2SDdtkcjWWoWL6iqnT9nwaozFA/ol2J9a1g7IIK5qxCePXPm2NUc0L5MDIOlEH
	 1g2FAQSn5L9jgBxyfKvwvj/6j1KPF2jVtIchCH3WmCCngS12UxHkn1hI4VuCvD1l9m9sm
	 BKNFoXNybhc8EQ1rUOs9aLtRdmjqb2yEtJrKEHqjEL1YO2IuTAt4TrWSHwSwZVmSwqj35
	 iWUdAQlHDWdDWgiojliw9AiXUM1R0WwlazRcem2T3JQfFHzTCwp/kPhwhRRet7/xlAY61
	 3b01OJjxy87umT8nl1Le/OoakfEQ/HaR/NLStj0Kk29sKqGF2NYuW4+ijn7DsMeMqTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XCG/hpoNHIW0Eu98Teji7EwKeVbJHc3B1VUMeilrzfc=;
	b=Vruefls1RBFrC5L9dgyHaIip9pS4b4mbCqKImmmuUkNNPdfGKiSjEABckZ7MRETwHUAi
	 3VVUMpe3uLoay0LmavIj39sJitaJe7MChfn+c8spI+LWo3GPAU2+sGI/M5X1CAKPapQTw
	 QJCwWpcA+2TLuoPb3baCQLOcpTGh2HzWsVikoa3GLps02RPv04eP5fG9Vo2tz/lUHOJyG
	 TUzBT9ro4MTcWlGc/ZoQSLwmTuMzI7xU9FOUhUC4SnEiIr7xhY00ZFuiBG2HcfNYuJ/e3
	 IMhErucEXG9E+N7DCfe5UZLlHwGp6F4+4lrYGQ9mXXoshTkTXBN3aW9+hQ7PMhXImXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfT1VovT;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF667606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 02:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF667606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfT1VovT
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so5851994c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451235; x=1795056035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCG/hpoNHIW0Eu98Teji7EwKeVbJHc3B1VUMeilrzfc=;
        b=VfT1VovTUsPLuCQ7MctJPLbnqZlFTk3uSg1IvRBBcNsXsLUIKtblqmiPg8zM2YlHx7
         Aqywjz2lH85piwUeLNxNurLql7LQHyH98EtzkzVNeZfljO1rl8ab9Zr87XdXc+hWwNpp
         HnSUuqf2c0mcHIWdgET/i5u8dBEMbj0NNHTA8SKLbFRK+8+EZgUtXIVFHQnjZmeYbKGd
         YkBXb0+30fYVllP6gBZOd3qlem+T9T99ynpqynMDajM9BLmQAgf3tWaxzrgZ5er44RUD
         p2hL8JT1gnRdHPkDbo92SxAvtONrTJ4k/qzSQn3ilY9ZssKhtQbqKXeEuubbVAkaJlf0
         zMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451235; x=1795056035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XCG/hpoNHIW0Eu98Teji7EwKeVbJHc3B1VUMeilrzfc=;
        b=jikC3EQrwn4sDgHsi5MqgZDGmr7o68EllED2+6Oulse1VM4EVjuH+KhOfJRhoJK2US
         6xEUp50/EuUlVuQ1lFydyXd0j5sxGCYoR6EmWYttTWj1OFW7yC0wSPTZndR53Hfxz7M4
         lnnyUVGYpgE2lwA35oDa7SVJZPLLjaqG9KahPsY+LOUlRbosV/vr4QApCUi9x0w87mkU
         EOeOEn/ws2lqELYuYOo6jRykzd/M60Bcwtr34Wxq2NHVRPA2iRljHe6yX7ZBFNtK1CGR
         iM33GnQjJ6InoNiCXiXaSLgd92zzlmzgOgCakf2KPgi0F1bVDJugB50J/+5cUVHMYNd0
         wo+w==
X-Forwarded-Encrypted: i=1; AL+hErFbkcuMr5vfwfQZAk78wvq9gtei98pIOhjAVjb6C4E0tUrwtt2jm+HgoUn4UVD7sQY+tbymR6v9P9ty2ZuxyKyW@vger.kernel.org
X-Gm-Message-State: APuU4Z9twXhJNMMz2KWmmlzn8zC8nxBaO6+lylj0Qi43kBssMDIYf+zc
	En5l1Y3Rr4LGR+TU9c8uL4A+88MqooSrN0J79wWdpzbmMG7h+SqYfSZs
X-Gm-Gg: AYBFou2cqOh1VKSTcARX9N9snKn/Rlc2uW/id9n8zpKj8yUQ+10HG3LfpHggJ6FR4uC
	H9DLmWYla2ILr477ZUVq3IcEr0rD4Cl2I0Xnte5qsnQVsnm4hRCkm9gj6aBLvBjyUTnBQfKvY6X
	mzAPfdfJraReoGz52RoMgUl+gOiIy2+VEFW0SjignIaBpl3nrbyjNEoCuWK9bgQ4hBIv65oZnO5
	5Kg8t5VeStD/3vgJcC4pQecIssz7tQBQmZA8dIHTi5V130sZP8BE2fjXCdubpAiewyTf0FuqBBJ
	4UMw2mTNimA/pGM6u6KpzS5xPT8N/A/je1vM6boYZNBfBg5FHeUPSilQ27nogVt5fuaQgRtYadr
	Ppy7AqDttgEjCiYUdxgPNXpJefBxKGEMj/ZAHRZRF8PzlVLgMVVNi2gAcomgzSxvVuejWdXM3dI
	LQXxLSfWycbNWtN9IIbAbHVVVS3fMT37XEW32cAWzsxmJExfpm7d6/WfjPZa69lCJub3QVyM/DV
	bHajOALxgg1CtLazh1JEr1X89lQiAnEFIUDXyfhdfDoXE+zWYQHGgHFca/Dr0J3U04WX4xzwV9r
	kopoctiZw32xTx/1w0RepyRR8kZXk64f3PTWHPnvVPYFXtFLs4qprAxqxwVopt4lDxn56bDMyl1
	xVHBWqiPLicQ1vfjODqRLWGSRbCVTzA==
X-Received: by 2002:a05:701b:2219:b0:1b2:4378:3545 with SMTP id a92af1059eb24-1b3c0304417mr3841493c88.21.1794451234580;
        Wed, 11 Nov 2026 18:40:34 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b1003fsm19000961c88.6.2026.11.11.18.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:40:34 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	x86@kernel.org,
	kim.phillips@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Reject pair-counter groups with no GP budget
Date: Thu, 12 Nov 2026 10:40:24 +0800
Message-ID: <20261112024027.3678221-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109110356.27709-1-zhaogongyi@bytedance.com>
References: <20261109110356.27709-1-zhaogongyi@bytedance.com>
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

On Mon, 09 Nov 2026 19:03:56 +0800, Zhao Gongyi wrote:
> AMD large-increment events reserve an extra GP counter. A syzkaller
> reproducer opens a perf event group until the adjusted GP budget is
> exhausted. x86_schedule_events() then WARNs on the unschedulable group.

Tested on AMD Zen 3 (KVM guest, tip perf/urgent): a group of six
fp_ret_sse_avx_ops.all events hits the WARN without this patch and not
with it; smaller groups still schedule. Without your n_pair fix the WARN
fires only once per CPU.

Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
