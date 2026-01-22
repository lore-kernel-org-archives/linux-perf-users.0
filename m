Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815613A35BF
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051431; cv=none; b=dCFeiUuOEEb28rvboG43+rEEcjAJrH4ZtGjoZkBsRgpZYAVmOowesXGVZTVCUhgKqtjkqlAAuDGF1d7ZsESJ4dLMr6wG2HQUAdFfHdwbCzvnU+dvs1CFR1OarAnNOYaT+2ZrxGuRJAfd5LOtVoL2LQ8UytYGJ4obxXI8y7TjaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051431; c=relaxed/simple;
	bh=Z6aritqo/qFOafguf8ca1A0ks9hmI7a+qZZHVW2b87Y=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=Qu1JvWIB91CLG9pzt/ewRKC4/pCmR2PbaXHhP7BWXE+RVfUtxR7JiI7Pf/y+cynILVo3/Z+jJJJkdi3pA1fxd4dlKIEDGelidmJlyyCtGJ15N4vB/TNkG7g0cLKCzBWg/ol5AS6EcQ4SY0epQMSfvqIm9tnW5vcFiSdEuXJHAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MXk5xsqz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MXk5xsqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Z6aritqo/qFOafguf8ca1A0ks9hmI7a+qZZHVW2b87Y=; b=M
	Xk5xsqzSvC4xYjWPR+N+xC5TbqR/T2+Tkl4kQh1xemJcJzVBSDb0wTE98iipba/X
	2G6VDQfFx0Je3VaqM6wnGbtkAUUD5k7aO9W1/VLSQHVqK1PbitJ9itLhSQhCzz05
	QWKlXP/6nbFqCrhHb6aUFYBTDpLhh9BxjaYZwH8vpY=
Received: from junan76$163.com ( [182.148.52.15] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Thu, 22 Jan 2026 11:10:25 +0800
 (CST)
Date: Thu, 22 Jan 2026 11:10:25 +0800 (CST)
From: junan <junan76@163.com>
To: linux-perf-users@vger.kernel.org
Subject: unsubscribe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2dC/yevkwp4yGbbOkfn0gRhuY2UMays/0k2YJTc+sGtRjT/gIlcHZIF2PK/t6GOyuojha6TSNJ1MJxV5laKuy+/SNgKtLSpLhW4dCoGQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <56081e3f.2f68.19be3ae8980.Coremail.junan76@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jSgvCgDnxyEhlXFpwr5cAA--.55567W
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC9QEk1WlxlSEK8QAA3S
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CnVuc3Vic2NyaWJl
