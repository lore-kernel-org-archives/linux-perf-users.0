Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA338396
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Mar 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531845; cv=none; b=CN74PgSjxIOMTW0cVywINrv3FZFSdsfBZOXAvEzme69PwJJPOpHaLlT/fPkAMaTprbwMwu+yUoyLckgb6Y71oEToLu74s3ABuHmSXofkcCu+VNn08lDcsk8E+ilCZqjROP9RYc4rB0McCzScuMMqj7LyHm1GMsVvJXR5RvjR4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531845; c=relaxed/simple;
	bh=8U5V0ssHGv3ERdDKVymy+7j9aVJXlz/92WoKItReoTc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qFnovaKzD2YFJCDLj022AUmi75kXoXzWWxhMvjY30l/0Zen41WkGziSdG1sWcOJxWwtiJZ0+vTNPo6UV4nPG1n1gGVJGOOJHmxLCRlVJaDn/DpGO8i3Ctsmq9WFNWQaSeUVHDgi96COnDriId/R50Oxy1LaR6M6BL/W0Y0t+8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFO+J+jD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFO+J+jD"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515a81928a1so5480727e87.3
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Mar 2024 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711531841; x=1712136641; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7UCRay8AuwIz9HpPS63wa2tUnB2gmO0x8rdvv7Qwd0=;
        b=RFO+J+jDub5/3AVm2KFyCewArU2QlOUno4j9Zqr6+NXFfAUesieodJp+9hlHEKwgT9
         L8JASty/fNIL7Wztz/pU80FNrlmk1XBY3fOq31c4YtzP6YOoYj5m8zqNzxRUo/5nuOtl
         /GoXLxxkgmVeqVmtGLQUiGlOBkodZcsGHyjPdV8mEOvBwwhCMM/E0TK3bge2MT9YyuC3
         k9og/K9nV0HyFrHhh9i9m4KCZb4mLcow3jtkppeEF6t+NcwqPIf89ikNaMH/XGDDqBHB
         D6Gt51TpzhYHpEIaMg7qMwJY2+eGyXI8t8Rj8Ew6sn94D6CIb5G57jTz3hYoK6zvbVk2
         YKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711531841; x=1712136641;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7UCRay8AuwIz9HpPS63wa2tUnB2gmO0x8rdvv7Qwd0=;
        b=lsTRS5WrKPFRJW5NFBTQnsSr7VyKxdjAscrEEmvtlIAzQBury/FE7p3zwlR4KiRxj2
         gv/5D7BIeNt/ZueT1KcFwt9KSQ0XSkYdciT47ZZD75uPYAq/YN2ySUCK3em5WE9qABeI
         Gs7kUBA+6XeaTItCwLVrnC7kkLwqHhNZv9bIULVOFg3MzhTWNZWI7dhr5AN7HWgJ5KLo
         Lki1v5J7zY6So57EdQwL6TkswHQsvWHYZbhrD3I7YTJx1Plo0qk/3jj8he3LyLoNcCZR
         Ugma32UkRBCAl0Z/yvxqXqZDv7Dq9v4cMFcsC8Lf/B3N71ihn2rLGR9PbT5qw8pQg5Ur
         WcBg==
X-Gm-Message-State: AOJu0YzNsavO7wjofwP3hRlE64S3T22v0VABQ57vuArXrdK+ZG6v/v6u
	nc7U7BTO5n9WokigfwC0pO504yUCsDurWUnu5lHM1cx64c68pa4nopLTYtLo2gNpWMDZWZB8vqY
	OTjYQpxNJ+JMk26eQaAZIpVQLssZYYkCDaJE=
X-Google-Smtp-Source: AGHT+IEVO2odNQ/hbwD/KwpoEgIy5O4nhccgQ4Z/YZ0uC9a1533Dhyl3hUXd1XcaBneHxaUqOHBBLq6xqi9FtaVxFjk=
X-Received: by 2002:a2e:3008:0:b0:2d6:d2fb:3d27 with SMTP id
 w8-20020a2e3008000000b002d6d2fb3d27mr1652779ljw.53.1711531841529; Wed, 27 Mar
 2024 02:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: faicker mo <faicker.mo@gmail.com>
Date: Wed, 27 Mar 2024 17:30:30 +0800
Message-ID: <CAG9krM_+3QRyh4Dv498Hbcdj2KNbzzVkvSeMy-VfnyESx5-xZg@mail.gmail.com>
Subject: perf-kvm not work on intel cpu
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
   The perf-kvm record/report not works on intel CPU(like Gold 6133),
but works on AMD cpu(like epyc 7d12)
    The OS is ubuntu 22.04, kernel is 5.15
