Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838112;
	b=roN24rXI7WrMZ2Y6TiCErqqabEXF+kBZ0tkm47UP7Pn9qKV7KJVIZ+8OnSlFr6EL9na+
	 dvv23Ml4rVscYgE6gIo/K54coCQeAzajuq3HOcEvsCeno6GsbhnmeWcZ0A/bDbKawVk0s
	 4TiwKTpMqhzlSYumkKpaAQ5QNsBOdrhwskTo1RQ6Txw1ioNmG8d3JCl8KhSxg0i4/hwb2
	 cT1QQ7NuND6+rY4jBwzPFvZ+D0vk7ObBRW+/LtTEeR7tCIF7DZ5JtazZQ4utUHar7qpW4
	 3eRaCLBsJTbrrP0JPJ2prfjf4PQXvsK1r5VAxNMd2g95j7ydEpt7fbHmOUPahpN7eGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qr/RK+Rq5dWLkIxZAbRco5wc0OP6SbAvwmR36bqd9dM=;
	b=eilck+socl5iiqeKq3I1SNeO3/CaSpTdCtCBDDcttqpRFPzZs0heuzuj8JP4qjpW8fVm
	 F8P0in00O/3wJhZ9rSJU+8LolA7QjIK9BHlh50wmVugu639stpcA2hSuO9IT/ELCgy/aY
	 F5a29bO72D9CdEwRjBWie9T9uoLQum+fd+U6kmXNnejEj/TyDy2NmzAfoh1AzdDX1NI3n
	 GrZVqkNF4l8ccWLcZ0ODLAERAhI8GMn47TXK2Rkm5W+YOxb/zeY+hcz+LdMDdmRhxu58J
	 e0YMQZRdIiEnS046vVgKNPoQC83uR7r8NHU9AvN0Rc2Om5qdm5XajNB7Bhgkjswh+HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7j3vrxs;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C331606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Nov 2026 03:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C331606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7j3vrxs
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f0426a65e0so52364135ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795838112; x=1796442912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qr/RK+Rq5dWLkIxZAbRco5wc0OP6SbAvwmR36bqd9dM=;
        b=z7j3vrxsNuPQj48IJ4rQ8s7GhmpumDt/H6mPKRhZJCe2I0Ak+/1kQ7jTwjex+HRHiN
         omPje4CSLBu5YDqsW+LZ2r4z5OyAHcuJiGbwRIu5yrI++kVdBL9zCFL7O3+UdYsPfmIO
         LNufeNzboi9WdCytY57ZNu8oUAgb0+9DpOFES6l2pJRvtvOjC6Yf6jlXjxN7Y0FmJoAY
         afRG8gBCIBlcWbVYPYrTJzcqXg3ki6o8kHD+kdW6q4p/LI/mY85wyJ4YkjZP/xEjTA1d
         ks9sYVmHiB91s6uuY7txQBX0rx3fHznmIjRnn6bOO1WI8MVM8c2Xl3TrlBihM1PNJQtn
         KAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795838112; x=1796442912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qr/RK+Rq5dWLkIxZAbRco5wc0OP6SbAvwmR36bqd9dM=;
        b=Zq1J9QIGVMsFA6RCgOoivgIIzyBx5YGDXNDa8jjRWedtig+B87ogvLQIfyHwDyReGd
         SXHyz/NHXlGBEiTig5efNNPFsI4BP5zCYbDHwqeUn2DqeQEF93x0YaEQktxlx7lcV136
         w/sXKGDRudn9FPSqnxvi1S72a/5Cvc8m3r17m/Ub/DK6iNoKB6/ABXjNKPLJy68dULKH
         xMbLPwn/TVJq8pNETw7oPBTtyfXVHUuBu3dx2XEMLm0Q2md7mGGsdiNgFCp4jyjr442E
         I1gZjLjkq5QS0ct+DSN4Fvid1/keTElnaPiOJBI7jpXYoVMhtT2mQB9YY5WxDAGtiZJi
         lghw==
X-Forwarded-Encrypted: i=1; AL+hErEBQekyLrLxu1SNjZAEk2nFxRW5ig5oNg6r9/FlhNqmVodA3AJhAcoXV6b4kkFVLGEbbO8yekp3MsVQhbNAXizD@vger.kernel.org
X-Gm-Message-State: APuU4Z8w/q2Yj0mcqk5wcPpJX09nWvt3K7Wbgi6GGM5n8/AR5inznd16
	ETUnf5Ts2oUP0lEW71hrsicLS78uEnWLKoiteWbxTq4DnULxOh7+LR74
X-Gm-Gg: AZFdTZdd0sLXOFr5askYJ9utdTO9/BwMIkR0unEowiT6LQRs5UQxz+ofLtsIbqaPh1i
	Xqb+xdRgExUbYImYi9RncwbuCmJy5rllE7j72Pg0XIuQUm7psBfyocQ1JGBOsyDlRgbyVFwbEd1
	fbZv2NfGKzDgDYmtZ5b+dFZ54hvKotI9Or96jCRhlsZZIh5njrSrwxaUJerIvfx4k8beHGwLTRJ
	ozwzLwn9lM1wXq6mIulGnNvsQnY66YXvxmTShNCIb6HDRll8/PThhq6b6vG2LtcBWXp55fuxhZH
	0hYhiwBSsOslfTy4bDOLDAFu6er2Crrj6i/o7L1YcC75rhzWxUsdX3Ea/01uUcX6drPJJS+J3cF
	tJk4kY+fJBe4meqocTwFGJKDH1c6XAK1UOpSEmaWegN9a7Mn/GenNjTwj/72Jv/lCbHwgMLPSVP
	SGBthZ7VRAI5g//Ls9j0XR3wc5qQeqfwAw9tlrFgfVa8cnFNysKHUf8FAU4AM0kkYj027Sb1Wlh
	ZxetvFkLYM75hUgHYAwxKAU3xFXNVHlI/oDxzmp013LNVgQ9UFDH7DuvkDhLPBTwtwe/u61lkI2
	fEAW0r8b03iClwI5LOifR5AFuiw=
X-Received: by 2002:a17:903:41cd:b0:2ed:5548:2989 with SMTP id d9443c01a7336-2f03f20115cmr222838275ad.30.1795838111725;
        Fri, 27 Nov 2026 19:55:11 -0800 (PST)
Received: from debian.. ([192.227.246.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f099a4d875sm89190595ad.37.2026.11.27.19.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:55:10 -0800 (PST)
From: Harry Bit <idleassetsd@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Harry Bit <idleassetsd@gmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add phytium
Date: Sat, 28 Nov 2026 11:55:02 +0800
Message-ID: <20261128035504.760778-1-idleassetsd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Chen Baozi <chenbaozi@phytium.com.cn>

Add the vendor prefix for Phytium Technology Co., Ltd.

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Co-developed-by: Harry Bit <idleassetsd@gmail.com>
Signed-off-by: Harry Bit <idleassetsd@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93..374568acb2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1331,6 +1331,8 @@ patternProperties:
     description: Phontech
   "^phytec,.*":
     description: PHYTEC Messtechnik GmbH
+  "^phytium,.*":
+    description: Phytium Technology Co., Ltd.
   "^picochip,.*":
     description: Picochip Ltd
   "^pine64,.*":
-- 
2.47.3
