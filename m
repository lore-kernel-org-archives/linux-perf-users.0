Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C839CCE3
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308838; cv=none; b=feUq4Evqm9TbLYDwf78zlOWUfgWWnZbImFK8+Tj3qFIk1FwwTvGbRrKHbqYcOS/v3g26ablcrSnH0VNEl2Ry6QV6cG4KrxDShkj42Xr6BIMiy/D2ZZ1xK5CnJmIOSI9MCweC5t+XaysgEZswVNbwTd1xj0KA9PKW/4EM9IH4WiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308838; c=relaxed/simple;
	bh=wEz4ZgtyClYNkXkc982cJpCMLDOhGyTzlEE2gr9dDuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/anjM0lJerAJTcjhTraqwdBF4utuPCm2tUrWfiy1ds530vZo3Iu/JYMUTqEMRMVPjT4LCx3wsBPT04FGnw0WnWldFLpntt1O1j2cdWNQHF+wJ0R1d62FNzVx6ro8kSE4ukTbLEchbs45vJ1jpIOXrl4Rcr9inJdTAfDW6mdoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkkXrinn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkkXrinn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccf2360620so6894905ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787308831; x=1787913631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a84/CZYxm09NelBeAscuCZNpIQOvpqYpxGXt6sid6wA=;
        b=UkkXrinnxxZQoiYcmOBEwmQC6Xu01y6Da6eZX2blldMixvRSJiXsWRa8+KSRW/oOkQ
         6KxuCXG1NH4NYLIJ8ZmHug8OMGPQqsXTOeYUZOAeqVe3skdZCdceYGRse5cNGng8nbbH
         b1spkmYtsfzXxT0GX9rNz1vRqII7FdFw1Pf1CbPmjW1REAsa7F+Ps5bv0Is9U5Qt1Jnz
         XwmGohY5co5Oqlid1STy1vhGIjkjWBzzN6tcSOx+Eo3DL9DwGHz61iseuMxqzbCey6QQ
         iOqUBTuAQjvXo60CDw/Jx2p+S8pHIrnJOB5H7H+qLUhZteU+M+s7xns6CtmwKza2dYnR
         Q3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308831; x=1787913631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a84/CZYxm09NelBeAscuCZNpIQOvpqYpxGXt6sid6wA=;
        b=a3LDVM9A25XHfklJPvfRSvYAZ23sW0QhaNYvKTzU30HRCJmpxIRd3yLY29U8xXAM2C
         Gpd4iTKU5TDfaNErwkaKeKxUNqGTcI8WICV5vbpb9WSmo7UAlY3xDNiT6DcAeLPO+KHm
         cu/apRSImdC4O52TQI4XGhoA+lT5VxRGMAokjCQgFuP0KVB2sA8o0tqoqt67os7lbdEo
         QwxSmz3OBIidYnUk6Yw+M6wtpg2cpQGCYJ2CaZbJjqUNVAItIu+DNP7mt5SOyMwDWim/
         nsAH9W7WGSoDyT2i/h9tv3gbktFogdb8QJF8f6eI6qfrVRyibaXOVvtPEFPqgrBfnESu
         EfdA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9sa4K7Eo2SfJeHGZKebXwIiyjh4KtbVW3gxeaCgLWQcg/G0IdDxjeB1q25kBOU1ibb0y2CxUNqTxqJZnVp6YB@vger.kernel.org
X-Gm-Message-State: AFuF++ko143Cj6yOvd0TtF4g6pTCtXflaY0JvLC8b4Og5IRpswgbuqvw
	A9TQiGKnh2gbKFwdCzYbJGo7HZOElT2cPulCrAz2IEefl36Q/xykT3er
X-Gm-Gg: AR+sD13Qdto6IaOjN3MZUTTZNAKkVhwFzQRAsMcOv+mzCZIWhtuukK2t7ItW3GW9pDd
	UyrAqKd5nfk338rzrFpCtUwD3n4+pu2TEh9a5igBfJvQMqmt9zQ0tceVUWop7vTuz+FJRbouVs2
	UwcwnJnY+2/FWqtKLmlY/9cUO3T4ZJ1f9ylwG+aCNatw1n6rR3vovetogsZS1nEgAGnSocBiuEy
	QoI7EXVkcAUNlTDYUaHxFPRxoW7NEaJPal9i/syA/Txj0N0gQR9vZg2W+PCkx47A8dcAlBopGdw
	7gV3hGGM7jMKewpyRAcomBcRe67NExBmprPfvm+v6SI5hfS5OmZZi3GPFx9s5T2tnY0cPs/FcCV
	U5hwO7fiyaqQ/QmJSOIsElk1orWqds55AtJ112fno1irlR03qGipUjeU9m1J3hVsyEy2gxFl09v
	Xp0go/q5UPbOl8ASArekskUcxxOjntxlL0m72vbW043bXNN8D0ob2umCuNFQ7mq5nyAv7G9Sedv
	hdv/jA=
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-395c35636acmr10522154a91.7.1787308831084;
        Fri, 21 Aug 2026 03:40:31 -0700 (PDT)
Received: from localhost.localdomain ([2408:8409:1900:2232:accf:ab29:4a32:29f1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c18fa7sm2875406a91.14.2026.08.21.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:40:30 -0700 (PDT)
From: Li Fangxu <lifangxu22@gmail.com>
To: r@hev.cc
Cc: acme@kernel.org,
	chenhuacai@loongson.cn,
	git@xen0n.name,
	lifangxu22@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Add rust target flag for loongarch cross compile
Date: Fri, 21 Aug 2026 18:38:30 +0800
Message-ID: <20260821103830.2232-1-lifangxu22@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHirt9gpik6SuGSri9yaOhBbuitDeyXrekpQ5=vbN2u-_aSKfg@mail.gmail.com>
References: <CAHirt9gpik6SuGSri9yaOhBbuitDeyXrekpQ5=vbN2u-_aSKfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for pointing that out, Rui. 

Please disregard my submission.

Best,
Fangxu
