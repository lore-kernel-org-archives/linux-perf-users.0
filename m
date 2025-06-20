Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E20239E91
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457920; cv=none; b=b0Y4js/UDxcsEmupTBSNZdKeuB2/BxkquXQeAgbotlJZX2rdmOmg9PpXyq3xZk66z/E/0PDm/H9IxANhjTkBkr0yyl+THGxmbxfOC8aCWhcmiJCEisQ8qGewaorvPFowOR+d+S7fMNQyjB7UUjYsuy1GHtkY8fU14XOSU/AI+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457920; c=relaxed/simple;
	bh=ZTAgaNMzI4qiekOqkv3pNeLxj5wOqxlFzSL0ObZQoaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkfGBU4vELfnsKbObI8CguOlDqm349Jir2Wc1c5of96vmzlVVT1DT/FuO/X9YhK33SH+MYM2TS7zyqTZyWtB0B6ZH5aAdcrZuF7vAoAM22kYtJC3+Tn3j0B/Gweo9un2qJbVIjGkii6UVtjunifsgeszUs7XAbKHfAw/IrqsNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1fTMjpl; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1fTMjpl"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddd045bb28so21157875ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457917; x=1751062717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgz/COFsBAperIPw3jbaNsXNDBcCpCZIFlLHMRVJgqY=;
        b=B1fTMjplXpGS1iTbK6dYeZ95fWN25oPNuUEbaLnxmiqKHrvP8hGzncZCU33rzqojcg
         uYmnJ1g+kLVwiCdMxgEeuptR2jPqu8cAKAtFlqFVlTXogG+MpLeRWABIeaE5neV8BxAo
         NQz8QLdEVf59XiyH13SvbeOAq3n9oK0rRM6eBZamwYZ8RgoQ5qSsaPNIGfSQBG3Xgcs3
         zX4qOxT6Hm4ET9WfOW6KlTX/PAa9qArUfOz0ZPcMHSet9ckoLHrh9K9DhpE8mXUywYhr
         NSmfD1+kGK0XIpfVQCWvk/RtW/ZEeOO/ALT4Nf4uKW+eHq9VZjkYtdyLnyotyzMQj2ZU
         Kmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457917; x=1751062717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgz/COFsBAperIPw3jbaNsXNDBcCpCZIFlLHMRVJgqY=;
        b=mVr/yAEi+I5PdLQGHs+jv5Smehb5RJY4UNUCzKRt9biqPOBVs/SNWwb1dfgZ83qrZb
         3A6tgXnz7iXUEnQ19m+NhSOcpfxlp9CNeBPw6ZbVllGllu5lDLdXEGexEwzdtpSFREmF
         /gULV0UdXFlFcpEnESdGRjLAFW6zkjem5cbLVgW0mN81MtbsURKlvhDWSumyCZ2959/Y
         aykmHco1v1GFotziMrw3pssmS+mFDO1il9Y9K4hvig+NAfjF2akut2bAkLe616HGkI1v
         Yn5Y3smNzVSEkTM6zu9LY6pq6FMxRUL3qJXCAHGtARYKYbq+H7cjmx69SVp+gY4P1qxE
         +R9A==
X-Forwarded-Encrypted: i=1; AJvYcCXxDYq2KVd1aCuxCcPCWvhnO6Ejp97Cvft7/awuUBx4dzs6BPuqWqIq+OqQzVN0nBoa5JzOgxMSJPmGs2SjP88/@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkedlvBRjqbldbBpr9ZmafM7hMdOd6twMElLbRWxKlNgbkBEZ
	NLYfn1DtGdgzPb/A6lIBqRGuqUnQJWTdsf0QBZqzhU3P2QsfDH1xHB5HHDvJcccFYMXhoyzR71Z
	T+feDEQdqDGj0xNHfZ8m4FVpkNw==
X-Google-Smtp-Source: AGHT+IGjEFFNY2ukf5QiVzn6d0Iwii2o/2bYlxITJ69QjxdmPFLoVLBssIQF8Rhp8gGY8wow9/U+VX25kMai0q6pUg==
X-Received: from ilbee13.prod.google.com ([2002:a05:6e02:490d:b0:3dd:bec6:9d56])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1646:b0:3db:86fc:d328 with SMTP id e9e14a558f8ab-3de38c2e1c2mr57720245ab.5.1750457917550;
 Fri, 20 Jun 2025 15:18:37 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:02 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-3-coltonlewis@google.com>
Subject: [PATCH v2 02/23] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

There's no reason Enums shouldn't be equivalent to UnsignedEnums and
explicitly specify they are unsigned. This will avoid the annoyance I
had with HPMN0.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/tools/gen-sysreg.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index f2a1732cb1f6..fa21a632d9b7 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" || block_current() == "SysregFields
 	parse_bitdef(reg, field, $2)
 
 	define_field(reg, field, msb, lsb)
+	define_field_sign(reg, field, "false")
 
 	next
 }
-- 
2.50.0.714.g196bf9f422-goog

