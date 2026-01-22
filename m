Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1FB1A9FBC
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058612; cv=none; b=ADBMeLGfwkiPmpVDF4ui1OZgxKPxAB1oWSN7bYfjpJ8FGFDii4XQktvrbgAOGJkiyWBAHqBp+upW40+vxneKYKfLXX7oVUH9b5i6jfm3aufNRiBrjtRwIbfNDwSiiCaAFQi3HSOZJphlpWuf899OtuuOwHz9WfEQmPQTx7Ai72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058612; c=relaxed/simple;
	bh=NIi76qY7cd1ykzdRuR1lSH0x2CmWOBGyAb0Qs2S0Whk=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YmsqnH0PO+pYiMXUKq/a+gVVgipwWAEZsc/qhtZN5nWzeEsccspJ9hxlGzgy7FkfO+iqCrzagM4Mb/igoyz3mR2QLYwvBSsnLw5fVatc8ydfNFsCWMe4c5XDARvVs4efAc1JeEBaAws4PumFch/OnCH9APObwurx9rKLExihCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EXpGPpn0; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EXpGPpn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NIi76qY7cd1ykzdRuR1lSH0x2CmWOBGyAb0Qs2S0Whk=; b=E
	XpGPpn0lKdySgg5/UVz2i2AAjVHMHQv69MZWy5d8pehdNyr3DI6cOf5VrcA+ncjn
	2kmhf5uz+JHjmtQKDxdxLyFvCCc8LtnSAOOkJJ0KmupP01ALbhPrGjIBAclpVEyh
	rHrVfAFGm1BbEy5kjkEhiVuM8ZKPeMfZpBp2zlb3ww=
Received: from junan76$163.com ( [182.148.52.15] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Thu, 22 Jan 2026 13:10:03 +0800
 (CST)
Date: Thu, 22 Jan 2026 13:10:03 +0800 (CST)
From: junan  <junan76@163.com>
To: linux-perf-users@vger.kernel.org
Subject: Apology for noise
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <56081e3f.2f68.19be3ae8980.Coremail.junan76@163.com>
References: <56081e3f.2f68.19be3ae8980.Coremail.junan76@163.com>
X-NTES-SC: AL_Qu2dC/yet04r5SWaYukfn0gRhuY2UMays/0k2YJTc+sGtRjT/gIlcHZIF2PK/t6GOyuojha6TSNJ1MJxV5laPlWqo5gXxvSbLz6mTgZXAQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <542bdcfb.42c9.19be41c1213.Coremail.junan76@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jSgvCgD3f0crsXFpkdhcAA--.52614W
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC1Ast3mlxsStybwAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKU29ycnkgZm9yIHRoZSBub2lzZSwgYWNjaWRlbnRhbGx5IHNlbnQgdW5zdWJzY3JpYmUgdG8g
dGhlIG1haW4gbGlzdC4KCgoK
