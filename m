Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=196.1.113.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895618;
	b=NbSr+Q71DUz/RfEzBZDEU9y70Ov6b5EXINUvRhZ0KwZAr8fZKqSPa4P7K94Fp82hBVHN
	 h3FZz+lAxIQlCX42p0k7fCzTthdn3gSLFsb9m5jc1lbL47yMccoqDaQlxAFqD0lVENale
	 AdBDG98WBj6dEcVgAyOdn4vyEFhDTOEmGB3oe+NtbzzZUUd1wdCXJ+iOT468ZozeN6X1V
	 VTKbTSsnj9p2T3E9MPz7xrANow3CUo2jdVowWkSVIMr6VRzgtrPAkFBzfIrC6W9/GDPnS
	 sYx7yNbNviBlcLsIyTPpQO7EbeXL4XX5VnxMC77kibLzNzW8VvsbW2AcFFyOn95uIOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895618;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:Date:From:To:
	 Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Mailer:
	 X-Originating-Client:X-CDAC-PUNE-MailScanner-Information:
	 X-CDAC-PUNE-MailScanner-ID:X-CDAC-PUNE-MailScanner:
	 X-CDAC-PUNE-MailScanner-SpamCheck:X-CDAC-PUNE-MailScanner-From:
	 X-Spam-Status;
	bh=fspsaDB1VpBVWIq+Zep9LhfWmik4IX/EaBah1N/sETQ=;
	b=PR4lSmvYdZnvHk32WueGwhHuWoZ4c7vPUbcbWNs8OQl/qYcW3ohgcVEQY9u8jqPiVebg
	 +1mEjV0GfwkOS4hCTZRymPJ9/itYKtXu6mZDyiX0Qwiaqe0tyBzBB8fd4zUax+Ng8H3HT
	 Ey2iEcky7DklGvXiKl1qM0U24M1FZbZU4AiEzj7OYWUghKToCNo+hMCSfWxIMkxOgSz7h
	 RikByrxECGPyRKWqs25tKfAgui6pVI8NfDZk1PitE8fU+v+dkk5nhaEDyYhTVmsFZ4wbr
	 NwmtpIC/30fFrk5ADLdgK1esUvM2OkOAPdLuGuWu/KDzbYhNOxXRjiWyFm5gwM/Sidw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cdac.in;
	spf=pass smtp.mailfrom=cdac.in;
	dkim=pass header.d=cdac.in header.i=@cdac.in header.a=rsa-sha256 header.s=default header.b=mDEjtDAB;
	arc=none smtp.remote-ip=196.1.113.117
Received: from mailsender-core1.pune.cdac.in (mailsender.cdac.in [196.1.113.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D88606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 06:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0D88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.a=rsa-sha256 header.s=default header.b=mDEjtDAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
	t=1794895612; bh=zXq+V/d90zrzRSfb+HyqqUtwtLxb/aDa7XCwBI5u0Gs=;
	h=Date:From:To:Subject:From;
	b=mDEjtDAByhWPpT196y6SEULNVlKtL5UoVj7R+DxOhsscKB8OOdFBmPtnC9GAYTVAq
	 PP3FdlWSdaWMIQxZZklSJc3h0z3JApRX6LdT5CbVG9o2P6QORY9ZWoeWe9zkzVqx3U
	 +WwV0Ig499lQC7GDmM1T/gtwbjYcJm7ov+BKXE3E=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
	by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 6AH66pJ01637718
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 11:36:52 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in [10.208.193.46])
	by mscr-int2.pune.cdac.in (Postfix) with ESMTP id 63E601000AB3E
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 11:36:36 +0530 (IST)
Received: from webmail2 (unknown [10.208.193.8])
	by mailgw-cip.pune.cdac.in (Postfix) with ESMTPS id 5D80514E086F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 11:36:36 +0530 (IST)
Date: Tue, 17 Nov 2026 11:36:25 +0530 (IST)
From: Rutuja Sandbhor <rutujas@cdac.in>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Message-ID: <1662286702.77676.1794895585598@webmail2.cdac.in>
Subject: T-Head C910 perf events: question on stall events for top-down
 analysis
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev30
X-Originating-Client: open-xchange-appsuite
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more information
X-CDAC-PUNE-MailScanner-ID: 63E601000AB3E.A35FA
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-CDAC-PUNE-MailScanner-From: rutujas@cdac.in

Hi Inochi,
I am Rutuja from C-DAC, India. I am working on top-down analysis (Levels 1 to 3) for the T-Head C910 on a LicheePi 4A (TH1520), using the events from your "perf vendor events riscv: add T-HEAD C9xx JSON file" patch. Thank you for that work. It made perf usable on this board.
My setup: custom kernel 6.6.66, perf 6.12, perf cpuid 0x5b7-0x0-0x0. perf list shows the vendor events, including the L1/LL cache and TLB events, ifu_stalled_cycle, idu_stalled_cycle, lsu_other_stall, lsu_4k_stall and sync_stall.
The C910 has no top-down events, so I want to approximate the top-down categories from these stall and cache events. I could not answer a few questions from T-Head's documentation:
  1. What exactly do idu_stalled_cycle, ifu_stalled_cycle and lsu_other_stall count? Are they cycles where nothing is fetched or dispatched, or something narrower? Can they overlap in the same cycle? In a latency-bound pointer-chase test I see IPC of about 0.11 and idu_stalled_cycle at about 94% of cycles, which suggests it includes cycles waiting on loads, but I would like to confirm.
  2. In the V3 discussion you mentioned a fault in T-Head's documentation and that you would extract the events from the vendor perf driver. Did you find events, especially stall, cache or TLB events, that do not behave as the documentation says?
  3. Do you know how large the skid is on the C910 counter-overflow interrupt, or whether any precise sampling mechanism exists on this core?
Any pointer to documentation, the vendor driver source, or someone who knows the answers would help a lot. I am happy to share my measurements if they are useful.
Thank you,
Rutuja
C-DAC, India

------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------

