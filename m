Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048549;
	b=2CaYquNrH6f9F2Hi/gc9fTqWuJFndXl0+nmqv6SY9SywxzaLPWM3FlxjmT0KSuZpvim9
	 kJeb7uDPRtp3nkgK3rdx2t2GTL/8ne9OFPtTRf4GwgE379fE1ChNJrdLrD7/gmdJWZBoN
	 YJTSRp9Y2Jm+AzuefUjcUywlovkMrfs/e+PrJEaQuo62ucdhgQ9tQCy6Xb5iYWIj20Jd2
	 hMVr5Hu5gYCV+SJ7bZPQgyk5fIViqLuBYgSNC3LQ+rasz+WfIWL8Scct3VlWTDcUx0IL0
	 UKZTosSmIHPNoo0ML4FwWJbvXvxaLnnS9TP2KhAGwFd8HJajMj3KkD4qGVdtZdGaCrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jidyAGpI/ALPwLuz5xv9pAUucASQ20+cL1hbAhUU54o=;
	b=VVYD2aGHLpn9OY2GPfTt5a4+FRg5Nf0955u/iVdMI0NvI84cGzwO8Fl96PN72nE8+yU+
	 3ksmnKAj+BsV+GMCBtaOxrnsiUnymZQhNUCHyx00JZNnl4fP9vBNKqqGXE5kO/VHCiYsr
	 OQxAKCoatFdtT3wrXz4htfwWF8uHOBa6eGZanRR5ycgAD3f26Z0LS76ebbqXzGnvbVhut
	 KrYdmYv/VrnK+ZmaEtCBPekTO29E2cCgAS5f1Z7ivc2uwK+Q2OjlbNVn146q1f9kAcW7V
	 A8dNo6jO6Dr8mGRmYwOpXhANrtpK5fzkzqvZOhSH/CFPwMEboqLFDhIbRCcI/3NSa8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bd8x/4h1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40B606EE87;
	Sat,  7 Nov 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd8x/4h1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048549;
	b=x4CQw31kkPDB2FyvRn9MeZpipKRlttG3S61CztU8n/TwdiBMER1qEU9wEhlY4MoLazr+
	 iiwm5r9qhQbz2n3QVlK6Qehq9m17TGmgsFNGX6qWlvNAHaKjone5r6j3K52LtDWM+r4Yo
	 zgY5o6gALid0d2QU8jwO3xeA4RVmnD8jaWoLl7BAv/9/CC3f0KElseSkKP05kcNeegdfs
	 +oAr4ieqf0hOt/0KTREi9kRGb5bqmmFn8wvhSEZDezc9cHv2Ptqe+mkfMWhC5mPxHhHum
	 o/6ucicPacJD5p3ZqiXUYCenRy5BAAVs6DyPQL/6dxKrTcB4jOIWOQQ0eqfc3rt71qg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jidyAGpI/ALPwLuz5xv9pAUucASQ20+cL1hbAhUU54o=;
	b=XcYoDgOy+llJ2u72LqznLs9PJVcPuDjYs2FXHphTjzOGQ9h2BYtjPmmDIEqiwcGj9WOf
	 8ra9UyIZdWI+CS/SBInEPAqSUoKhnUkrKysvJ2HrEdaVa+HKxMpVY1u3mV7N5DrokH7eA
	 8UY4oOsF1FZWB1kcvkF+pht7rtl86UnysRgnkAhcf0vgl97pL9sYFG74BE8iMV77fTix3
	 yYwrYGbW5t011/Rqgl+E+mD8x7g6lbzvpHO5/mM0bmfwxK55aVhfsOm+Id9xB8EhwB1ra
	 pOt2AgIQK+84QGhQXfs4RaD/5V196y0XjxPm8bP0YRx91TJl8GQUsp1sttb+IPAykHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A6D2B1F00903;
	Sat,  7 Nov 2026 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048549;
	bh=jidyAGpI/ALPwLuz5xv9pAUucASQ20+cL1hbAhUU54o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Bd8x/4h1JOBcjEwgBm8z0wm27KUIxtggOMedsD2rF/Wb42r3GzdZba+9TYSyj6jqE
	 jF4bNvOQcDKsa5zwmNG0U6FUkXCMFVBgCtYwVhs/en1jNDTejUk5ztYfJ2iHHh6WXU
	 AXg/RWn0z0mJNJsmksiZdKL1NkyhIllRiD0yYQY7daDFRn6QjMPFvxXR+uoltp16uA
	 CQNIsMUxDjZwO/HEZ55axQ27hSSpzvJoQJJgxsdpT+3lEBdJNtyuUkEHa8mfJdxxR9
	 Xeaa2yM1Rz5S4O1peyUc21X92fgOV7RWbzzeb5c8s/xdtvgd2bEdxBibuYbphdXe5F
	 8LLix5c7fqIbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 400E447BA2;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:49:00 +1100
Subject: [PATCH v2 13/15] arm64: dts: apple: t604x: Add PMU Device Nodes
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-m3-plus-pmu-events-v2-13-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
In-Reply-To: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=tOGj1AVK13sDoleZ1GDPbZJP7wjR8LAHjlBELHNHOOg=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyUY8vKgjKjL3andcg8Nk5dDey0+fn1xW4bX8d
 OXNJ3n3bsl3lLIwiHExyIopsuibpmlPZmu4VLrMdQvMHFYmkCEMXJwCMJFJ/xn+O+079oU58cMB
 rTVteXkGz9uSNldLm/3b1Sn2qYfVRGitOcNvtmWTsmfy6O3jqNv6PDL94/oJPE1qVlfPH6+4dvj
 u5RtnGQAEvU4K
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Adds the PMU nodes to all t604x devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t6041.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6041.dtsi b/arch/arm64/boot/dts/apple/t6041.dtsi
index 9110d05c896d..62d7c63042db 100644
--- a/arch/arm64/boot/dts/apple/t6041.dtsi
+++ b/arch/arm64/boot/dts/apple/t6041.dtsi
@@ -314,6 +314,18 @@ l2_cache_2: l2-cache-2 {
 		};
 	};
 
+	pmu-e {
+		compatible = "apple,brava-e-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,brava-p-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;

-- 
2.55.0


