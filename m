Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73F25B0AF;
	Thu, 30 Jul 2026 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454474; cv=none; b=cmpI0Xu9XCjYUyhq/Nm057/qZen5ObDfKOg3kSUSld3YDSn0CBluMlmqNCfF/aySpDAbHNuX1jZGBAg5KVBxrNg3A8cIygpdqhve/CHOQODjP0p1ggURxd+DU2e9f/mC8QetJyqcVVNduTZhD2jGWT3qtWZbSdJOotAzVPteTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454474; c=relaxed/simple;
	bh=Xfcw0EaXfk+UBTuRGW1lWE+oUOebMB0k0Rq45m/cvok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1zF104w6ktUbtNFGyu0bkGoyZ4lONy10Xba0COKthpa8sOAa14tMY0kwH6nuNuUdZz1QuZqPoDes2RcrQcZZ18YiE8ASF7YSUXMc8ggyhj3Rhxy1TTA5PTC333n8pc8/8koaZIfjUMjLincXHSby7+MxYa/34zGSStADjCMgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QicUGQMd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QicUGQMd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mrumHQUiwFA0C/d9jNkCvaaukNPw/u2nJrsAmIzcBDI=; b=QicUGQMdrrr1YJaa5cByAtYT6o
	QLcGu+GLejp37mlO2NhHfH5u4UV2LJXWdDj5TEiZ55VSewaVfbT/4QRlYRQFegxOLiH6Q4EaWObgy
	oLiVHiEBVFWsjGicGnYpkPcgbMctUF4qZrd9mxaUAILwm/SBact9Qf7GvatTDmw/7fn4/oc2skmEJ
	vxU+EmD0PaA7j8TDRx7m8LwuPOA95fVzr7+rGRwcl2CII+bw/OXOyJTClK2cMGgpOAT0Gkp5vFP5f
	E5KcMO0m6O5H+/LidwEPt/HPjThMNpm4YcIJnyYRzmhp+FpaQSX8CQe52APVKNMcWH1rSPtBgjXNj
	U6HHj2yw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaGl-0000000BViq-3Rib;
	Thu, 30 Jul 2026 23:34:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/5 RESEND] x86/lib: checksum_64.h: eliminate all kernel-doc warnings
Date: Thu, 30 Jul 2026 16:34:27 -0700
Message-ID: <20260730233429.285788-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730233429.285788-1-rdunlap@infradead.org>
References: <20260730233429.285788-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- correct missing function parameter names
- add missing function return value sections
- use the correct function name in comments

to avoid these warnings (samples):
Warning: arch/x86/include/asm/checksum_64.h:23 No description found for
 return value of 'csum_fold'
Warning: arch/x86/include/asm/checksum_64.h:46 function parameter 'iph'
 not described in 'ip_fast_csum'
Warning: arch/x86/include/asm/checksum_64.h:46 function parameter 'ihl'
 not described in 'ip_fast_csum'
Warning: arch/x86/include/asm/checksum_64.h:46 No description found for
 return value of 'ip_fast_csum'
Warning: arch/x86/include/asm/checksum_64.h:89 expecting prototype for
 csum_tcpup_nofold(). Prototype was for csum_tcpudp_nofold() instead
Warning: arch/x86/include/asm/checksum_64.h:115 expecting prototype for
 csum_tcpup_magic(). Prototype was for csum_tcpudp_magic() instead
Warning: arch/x86/include/asm/checksum_64.h:119 No description found for
 return value of 'csum_tcpudp_magic'
Warning: arch/x86/include/asm/checksum_64.h:129 No description found for
 return value of 'csum_partial'
Warning: ./arch/x86/include/asm/checksum_64.h:175 function parameter
 '_saddr' not described in 'csum_ipv6_magic'
Warning: ./arch/x86/include/asm/checksum_64.h:175 function parameter
 '_daddr' not described in 'csum_ipv6_magic'
Warning: ./arch/x86/include/asm/checksum_64.h:175 Excess function
 parameter 'saddr' description in 'csum_ipv6_magic'
Warning: ./arch/x86/include/asm/checksum_64.h:175 Excess function
 parameter 'daddr' description in 'csum_ipv6_magic'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

 arch/x86/include/asm/checksum_64.h |   29 +++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

--- linux-next-20260717.orig/arch/x86/include/asm/checksum_64.h
+++ linux-next-20260717/arch/x86/include/asm/checksum_64.h
@@ -14,11 +14,13 @@
 
 /**
  * csum_fold - Fold and invert a 32bit checksum.
- * sum: 32bit unfolded sum
+ * @sum: 32bit unfolded sum
  *
  * Fold a 32bit running checksum to 16bit and invert it. This is usually
  * the last step before putting a checksum into a packet.
  * Make sure not to mix with 64bit checksums.
+ *
+ * Returns: new checksum value
  */
 static inline __sum16 csum_fold(__wsum sum)
 {
@@ -40,8 +42,10 @@ static inline __sum16 csum_fold(__wsum s
 
 /**
  * ip_fast_csum - Compute the IPv4 header checksum efficiently.
- * iph: ipv4 header
- * ihl: length of header / 4
+ * @iph: ipv4 header
+ * @ihl: length of header / 4
+ *
+ * Returns: header checksum
  */
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
@@ -74,14 +78,14 @@ static inline __sum16 ip_fast_csum(const
 }
 
 /**
- * csum_tcpup_nofold - Compute an IPv4 pseudo header checksum.
+ * csum_tcpudp_nofold - Compute an IPv4 pseudo header checksum.
  * @saddr: source address
  * @daddr: destination address
  * @len: length of packet
  * @proto: ip protocol of packet
  * @sum: initial sum to be added in (32bit unfolded)
  *
- * Returns the pseudo header checksum the input data. Result is
+ * Returns: the pseudo header checksum the input data. Result is
  * 32bit unfolded.
  */
 static inline __wsum
@@ -100,14 +104,14 @@ csum_tcpudp_nofold(__be32 saddr, __be32
 
 
 /**
- * csum_tcpup_magic - Compute an IPv4 pseudo header checksum.
+ * csum_tcpudp_magic - Compute an IPv4 pseudo header checksum.
  * @saddr: source address
  * @daddr: destination address
  * @len: length of packet
  * @proto: ip protocol of packet
  * @sum: initial sum to be added in (32bit unfolded)
  *
- * Returns the 16bit pseudo header checksum the input data already
+ * Returns: the 16bit pseudo header checksum the input data already
  * complemented and ready to be filled in.
  */
 static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
@@ -123,7 +127,7 @@ static inline __sum16 csum_tcpudp_magic(
  * @len: length of buffer.
  * @sum: initial sum to be added in (32bit unfolded)
  *
- * Returns the 32bit unfolded internet checksum of the buffer.
+ * Returns: the 32bit unfolded internet checksum of the buffer.
  * Before filling it in it needs to be csum_fold()'ed.
  * buff should be aligned to a 64bit boundary if possible.
  */
@@ -141,7 +145,7 @@ extern __wsum csum_partial_copy_nocheck(
  * @buff: buffer address.
  * @len: length of buffer.
  *
- * Returns the 16bit folded/inverted checksum of the passed buffer.
+ * Returns: the 16bit folded/inverted checksum of the passed buffer.
  * Ready to fill in.
  */
 extern __sum16 ip_compute_csum(const void *buff, int len);
@@ -159,15 +163,16 @@ static inline unsigned add32_with_carry(
 
 /**
  * csum_ipv6_magic - Compute checksum of an IPv6 pseudo header.
- * @saddr: source address
- * @daddr: destination address
+ * @_saddr: source address
+ * @_daddr: destination address
  * @len: length of packet
  * @proto: protocol of packet
  * @sum: initial sum (32bit unfolded) to be added in
  *
  * Computes an IPv6 pseudo header checksum. This sum is added the checksum
  * into UDP/TCP packets and contains some link layer information.
- * Returns the unfolded 32bit checksum.
+ *
+ * Returns: the unfolded 32bit checksum.
  */
 
 static inline __sum16 csum_ipv6_magic(
