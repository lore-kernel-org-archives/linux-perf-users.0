Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792681C6FF4
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674646; cv=pass; b=fI7qLUkq6EySEK9nS6/AS8IIcs7NBL3gGPOUDgltA8/qdSPFlOwrpPbdTmEGh7rElnL+CDLwAJK+uGh9OXhPvrlgGvP94KMBJcHJSqg8+kXe0G/Ucdc//+nWih3xgH2WuJ9wNsTaUi98lgGIKPd24Kq5hYMUsNWcDu/VY1rYK1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674646; c=relaxed/simple;
	bh=RrVUh0GsWsuuYz99GdX/TO16rbAn4Mr8NZXtDu+re/0=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=OBEA3XpgPCBkabS4ZUuL6nbhIajvUsgteVZTCyvbaaIS6Io9oRLDJh8neFmh5j3REqsvPDWKpLrOY2q2bLW5A9buqtctfpSf/36MPO/5PF6iOle5ES9pc/iuQtv0o48AygVz/WR3P7O276zRljwbM472fDbJXeChBjshcl3zeBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=EkI2DZMV; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="EkI2DZMV"
ARC-Seal: i=1; a=rsa-sha256; t=1758674644; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=cmuUIIs1NiPTH9I3Hu80pReaT/AwbSlm4FCeDEjtaTZiFdxd1br1opqrEPPT14G0E2dkiRUvCL8XtiAqWF3Xz9VieZbT/Abm0wWOez1waivmwuBJ6brm1LbQvG89K+AB+3CrCTtFpVGciJ7BCB91igldGBMPhTRvtfQv4ZWdYR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674644; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=RrVUh0GsWsuuYz99GdX/TO16rbAn4Mr8NZXtDu+re/0=; 
	b=d0m+olyzJq53g5oBRtPptTFGF/Z1A9Je/O2m7uFeizbZ2G3zhvlSfm4JIThjA5ElDCygARgTf+OwzuhEsHe8XpR7JpERhpd7WCjZRFRdcqw6BuEbLFsTUhAzQ83hetoRepDhKWl7WZHsDGP9kj/3Eyz6bJQi8+MOF0q/ztUrd74=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9aa1fab0-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653657185.60628680477384;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=EkI2DZMVaL1a9HRPOZ/ql5sEyLz6dpKoXc/c6qUHQK6ZZ0UfeuJA/akM9sLBPfVwIm1yYsItU0yfro7Wp5i549M6S7AK8m1hzVdeDmYzn59FgcDio08DMxOap2qTs6tkOvOKJY//hEdV4xv8nlrDFiDIrHOgHfJtvnYKDkYvsyQ=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=RrVUh0GsWsuuYz99GdX/TO16rbAn4Mr8NZXtDu+re/0=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-perf-users@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9aa1fab0-98d8-11f0-ace3-525400721611.19978ffc5db@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9aa1fab0-98d8-11f0-ace3-525400721611.19978ffc5db
X-JID: 2d6f.1aedd99b146bc1ac.s1.9aa1fab0-98d8-11f0-ace3-525400721611.19978ffc5db
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9aa1fab0-98d8-11f0-ace3-525400721611.19978ffc5db
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9aa1fab0-98d8-11f0-ace3-525400721611.19978ffc5db
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9aa1fab0-98d8-11f0-ace3-525400721611.19978ffc5db@zeptomail.com>
X-ZohoMailClient: External

To: linux-perf-users@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
