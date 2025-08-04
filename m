Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8B28A72B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Aug 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327543; cv=none; b=B20Uj0M7kZoRnFOyBGuraGxHBJjNJAdJSFzSAfkIQTWMz7bmCYWkbdKmRMg2/n8KgJos1hlQ/KXCTXvZW0SsaDkaAiBQVabGJlvjmRRKh2xR18gklWdg3wN0i5Y6Ndkr3NlaSl0fpB2u6Jbi7SNvQBRErPSF1I+AIYbQdhTmgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327543; c=relaxed/simple;
	bh=osaFbBrXvCaxyD5kJtQ0ULWmUnRjBvcTCCPP7k3eaz4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZVFqlV5s+M7R9UTQaeuVOpvOY6ruppMMkqGSi/9+7mL4Wz0HaZ0Yp9/M6DMRRJz3ZT9HUw5efWXV7U3xbdePq4ZRcgJVsXu5nXpZma+NC+oYTakFnVtfAplKp82+g5IXuem5EhsbXlG8Kc77IyV6RA8Qp1s2amdQr6AHmhBEC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsmDLgZy; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsmDLgZy"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70749eac23dso27994396d6.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Aug 2025 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754327541; x=1754932341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=osaFbBrXvCaxyD5kJtQ0ULWmUnRjBvcTCCPP7k3eaz4=;
        b=IsmDLgZyQHvMGiw3ig277uE88jm0EhQxde0c83IN7xZPFQXBafbzFLZxqwhtnz6By/
         +mCDyqfkS8SCRDlXvrMjQBWucr9PVoqe9zkmK8PkXOmwQSm4GnXFf8aYdyoHb/+ldnlM
         FeU3DomIKHMlIePylU0lEPnBz22ayPsIfEitFy9+69yPj2TndfinInAXTNKx3VO0dxm/
         njMKoKi1Vhzhbe9D2gcFSRDjwivpTy5J7HxAqfJAlQ+UBaOZJoIktZU/xWsxHOfzNpbE
         bXfJwldgl+tIw9AMEz8SwQiODkATSuEHrmJ6CHMGQz/asiaTF2Vip7yH3CxsiKsrRodc
         9oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327541; x=1754932341;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osaFbBrXvCaxyD5kJtQ0ULWmUnRjBvcTCCPP7k3eaz4=;
        b=L0iqC0shtyFhlgsexWaE1ZE+MzewW3vUntCOufjIWe1hQsdC6SgVuiTQPz8ziTCrzq
         sWkTblPouAAdwW++moSANQZygE1E3GzOjIZa1ByHK8IM2e19ixp19ufTOmC1aqpUnETe
         f9gAbC/CwLE/h149dxfwCl/o8YKyXkvwgiZWVYdOnu1JCTHcxZATXM/pUjRO0U9rBfM/
         DPeHE0t4TxrS+ZcfSYQyAKTi5n56n+5s6ZLyVIrMQXbRJ5X6UZI63EFjERsEkDw5EQ0u
         AEsKYFrPSf8xILXVOntumP1+rWMHU7nVdJZ08q2s1trnbMul44wDMhRYl6DuQ50FLXl0
         CTsQ==
X-Gm-Message-State: AOJu0YwiLs8JBcQn5gOcjQ4GWenCLWVIEky6yjK1Bc4cTlmtNy0TymaA
	XMPe8OcNSj8dCDBHvAwVnAOtjQG76WorzC822ZZfoalw9KZOdiy5VmTs8NtVGTx8MhZhWNXMRj/
	vxs2u2FruBGzWeH2Xomzi8kJAOeroI2N+Y3CW
X-Gm-Gg: ASbGncs2GhOB24ynxcmqk5oO9BRUviKBA4FwHYSvUXBa2BQhVhDDJAj+HT+30ASgmqN
	dIliCPd1yEi4WAwUonPxKnx5+1//JHCk2UJz8RuioC4UvqKspAE9PcdEqp1bs+5QLLuS2VXO9Nt
	QTFcwnjrsv8gJlsL1AnorecTYfysHXcrWFJ0U3i9PtOjNrbSe034S9Yojl/E3YxBGYmvJrv9x1Q
	FBV0Rco
X-Google-Smtp-Source: AGHT+IHr/6D5qnxoqyd6WdWJyDnXVBuTmzWMj7NJ32o86FhYgNI/sBXpWEXqhKlav76Nt3lIl9mz37Om7hTKTLFv0dg=
X-Received: by 2002:a05:6214:dab:b0:705:816:6179 with SMTP id
 6a1803df08f44-709362d810cmr145095756d6.38.1754327540586; Mon, 04 Aug 2025
 10:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Mon, 4 Aug 2025 22:42:08 +0530
X-Gm-Features: Ac12FXxnV-YRTHfb_fnUwybe8Arn3W2fG0xbE0LggfyZtjEnhBL3W9Ng6U_HJQ4
Message-ID: <CA+RTe_hnkKfCQk0HXj03_UA23EhzvDjCEZN7xBdEPzC3oGreRA@mail.gmail.com>
Subject: [perf test] Question on TODO in test_basic.sh for showcpuutilization
To: linux-perf-users@vger.kernel.org
Cc: vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello everyone.

I noticed that the tools/perf/tests/shell/base_report/test_basic.sh
has a TODO listed as follows:
# TODO: $CMD_PERF report -n --showcpuutilization -TUxDg 2> 01.log

I am interested in knowing if this is still needed and the reason why
its needed since we already have test for showcpuutilization:
$CMD_PERF report -i $CURRENT_TEST_DIR/perf.data --stdio
--showcpuutilization > $LOGS_DIR/basic_cpuut.log 2>
$LOGS_DIR/basic_cpuut.err

Also I don't think -U is an option and -D and -x seem unnecessary in
my opinion, but please correct me otherwise. Let me know if this issue
is still relevant as I want to work on it.

Regards,
Devaansh Kumar
