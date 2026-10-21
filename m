Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618242;
	b=lqiH2MjfltTlwQkZvFxohOxwHYNRsyvs49tHasZOLefLP9AmSlz1URxXQqIQlA+G4lM4
	 DxESdjEzDFztYzvrgWC4qSZoJXdpFprjlfiASW+8P+fD25M6f7TUW/zX0pERBdpJTwrbF
	 Fqp/roaEj3qwwoC8xEebPeFTZb9e/fc/Et3ZgVssKz9KCHcTb7WoVLWh08ZAKJlNXtSVl
	 x6HNxbVlwqS8uKz+ZbEOlE/r/7A6r+TVRocg60yt7qGNVSAyzOMz4HTmObkaZfgpUFIKg
	 Nx5hON8OgTTPexILiBOo+zv5y9XOCYq8u62f2HRNil5WXeZzwAw9HDFH5vNBK521mcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=exd5Y4lpCd2BrAoy6JRTGbXkcvsNWaj+DuTKKJkB4N4=;
	b=3j0p3BJw3MsooVD/RNsE2og0spE9GQA6XYWeU94mMOZTb9jjqnX3Cib+92qHWrkaUfAe
	 qf8qhWIAhS/2TtcTuSQeZIOicHJmWqXfzPFM7grAuEWL4KFJd7dxGWvIjjZ7oQBARfTCr
	 8CjFEnAtJD4Y2aFPH4VJAMuivPamFKoVROrWM0J6RIOjDaHHo4sxysmqsivPZt1AMe+4+
	 1KMlnPOSZJP7GMqcELuHq7YJ+BzmuDmnMtmV9qcj2mm//SHlLzDfUjXuoJqtJUNIvKxrl
	 RDaBz6HfGZtINTYmO1ZRmSbQnmovQ6LRyaujQFBcHvdKHOGShx3euFMR/snWr3Y1GiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SURuWWH8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F4606A32E;
	Wed, 21 Oct 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SURuWWH8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913231F000C5;
	Wed, 21 Oct 2026 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618241;
	bh=exd5Y4lpCd2BrAoy6JRTGbXkcvsNWaj+DuTKKJkB4N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SURuWWH8ifwKM7AWUxCkSWVsvrUHQvLCAN/eaU/um6IihHPmRy3KZRPOdhhVwSg0N
	 AEPcP6Op6xr9wY6cIf6UORpfqlGlObRC4TyxEhPVCETIEqK6a4F95U9FBth7XTrV6V
	 tPHGc0OXCq5W3aEuBHJN/ItEawhUA7WPf8HaI/lT7mL4t/ZXpoS6B63ngrnJYvQWJ3
	 8/i0thrXUfyVD9gEgArnpej+jymwj0DOpazVy6ZZB6zxtUMEvBFoycKUdxBbiv2k9J
	 mmNZK1Ag7QpkJnqR9hrDhfQ1aRQw94K0IVo68Sh7HZ/aFH40/3iQObUhrCy95ok97Q
	 wxgNJqi3+p4xA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v1 06/12] tools arch x86: Sync the msr-index.h copy with the kernel sources
Date: Wed, 21 Oct 2026 18:30:00 -0300
Message-ID: <20261021213007.21046-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021213007.21046-1-acme@kernel.org>
References: <20261021213007.21046-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  ac5cc691eb4a ("x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 9c26d4075c5f421e..3a8e51a0c9e88cf3 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -350,13 +350,6 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
-#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
-#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
-#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
-#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
-#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
-#define ARCH_PEBS_VECR_EXT_SHIFT	49
-#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
@@ -1014,6 +1007,7 @@
 #define THERM_INT_HIGH_ENABLE		(1 << 0)
 #define THERM_INT_LOW_ENABLE		(1 << 1)
 #define THERM_INT_PLN_ENABLE		(1 << 24)
+#define THERM_INT_DPTI_ENABLE		(1 << 25)
 
 #define MSR_IA32_THERM_STATUS		0x0000019c
 
@@ -1043,6 +1037,7 @@
 
 #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
 #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+#define PACKAGE_THERM_STATUS_DPTI_ACK		(1 << 25)
 #define PACKAGE_THERM_STATUS_HFI_UPDATED	(1 << 26)
 
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2
-- 
2.56.0

