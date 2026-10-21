Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567230;
	b=qjS0NtqQgfzoHic5JeUSNE9y6tbfB+tlozf2zK6aBQxpbis2/waiDIyQhqDJWoljb3S1
	 Brfbj76r9WEsd4zfwb83dxKX+dD+pFPkBHy3923XUE6jb+YZPiddjo3wxPvIT6c9WyvXr
	 sT6Z2ASSeXF3JQoLJ1rF92V/S5OpIzUXbcRTjZIL2cceJXXuFEmriP7VsCTw0nO3QMhD7
	 TXzTecF7uGlCDJvcTK+edPckOwaQOijdWM+jfhBgdB8d/XgxJBP/8LQug+UqxwUnOi5gx
	 KoT2WfCWRaSaHZ8lQBfFTYIsMZsHpvU2W3ewrvgiBN99tl/hfoxNCp0M6AZ2WAagA3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567230;
	h=DMARC-Filter:Received:Received:Message-Id:Received:Received:
	 X-Zmail-TransId:X-Mailer:Date:Mime-Version:From:To:Cc:Subject:
	 Content-Type:X-MAIL:X-MSS:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=VIZNzcv10orRo732XycMm56Jobni7WyOSQWYFAk91pY=;
	b=mk9YdD7vLWBJCq0ymqYVy/HqIaK/mhVR17dfBoQWqAdNsv9v1I3b2EQMegvHHzJlRr9o
	 VCT2bOBFZLFlA0ejelAEWzAYGvD68Imx3L48kGPO8TEoHOgWyAetaucnIdWKkq2ArUIDy
	 CpBQNWzB6M1xA5zi/D85YAu8G6vCjdbjFlSQbtBXGVozZpTihAreqOiWkysoEAnQsZcmd
	 JpvdXwhJbuDPsZs2LpQ4my0oXPDPI/QNcFvF5wiaQ+UL+hOyJ3YWoGTymg4DJakNi3wT4
	 PmZoru+ClYlfnXzME5LyLH0A9X4i8mQbQV6j2wCbbQ7FcvkAqycqBgZxqRv90qo0MzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C0606A319;
	Wed, 21 Oct 2026 07:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867C0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j8gff3HJ5z8Xrrj;
	Wed, 21 Oct 2026 15:20:26 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 69L7KOCC052507;
	Wed, 21 Oct 2026 15:20:24 +0800 (+08)
	(envelope-from ye.zhihao1@zte.com.cn)
Message-Id: <202610210720.69L7KOCC052507@mse-fl1.zte.com.cn>
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 69L6EsS0078942;
	Wed, 21 Oct 2026 14:14:54 +0800 (+08)
	(envelope-from ye.zhihao1@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 21 Oct 2026 14:14:56 +0800 (CST)
X-Zmail-TransId: 2b036ad8586016c-6674b
X-Mailer: Zmail v1.0
Date: Wed, 21 Oct 2026 14:14:56 +0800 (CST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <ye.zhihao1@zte.com.cn>
To: <atishp04@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAwOC8xMV0gUklTQy1WOiBLVk06IERpc2FibGUgYWxsIGhwbWNvdW50ZXIgYWNjZXNzIGZvciBWUy9WVSBtb2Rl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69L7KOCC052507
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: ye.zhihao1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 21 Oct 2026 15:20:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD867BA.000/4j8gff3HJ5z8Xrrj

Questions on KVM PMU Counter Numbering, Hcounteren Setting, and Migration/Conflict Handling

Dear Atish Patra,

Hi，

I noticed your relevant patches and comments regarding the KVM module in your virtualization work. During my virtualization validation, I have the following questions:

I found that the hardware counter numbers actually used on the host are inconsistent with the virtualized numbers returned after KVM emulation. Is this because you want to ensure that the VM can work properly in migration scenarios and avoid the conflict scenario where the host and guest count simultaneously on the same CPU and share the same hardware counter? Also, why are all virtualized events disguised as sampling events? Is it because SBI PMU does not support the passing of this flag, so KVM cannot distinguish between stat and record events?

In addition, I noticed that in your main.c, Hcounteren is set to 0x02. Is this also because there is no correlation between the logical hardware counters and the virtual counters? Have you considered enabling Hcounteren to reduce the overhead caused by CSR traps? In KVM, is it mandatory to modify the logical hardware counter numbers and the virtual counter numbers so that they match and are consistent, and would it be necessary to reconsider how to solve the migration and conflict issues encountered in the previous scenarios?

Best regards,
ZHIHAO YE
