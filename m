Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93033FE13
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650371; cv=none; b=t4AUt9nBjUw/yWcb/4STNp9pgH5h+x2zdfAB82yQaLVDTCZWhpEqSwYMMTxPrdTP8tPsh/7Qy7N32zPzrJKybYAJmW2CCifiT6uMadh9gTnGZhy1IwOh8X0fwr0W+WdoXMfvInLs6CUvYu6IFHmu98kVrOSjw/YeiCDwYXIgH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650371; c=relaxed/simple;
	bh=fJNbQYu7PoiJLsEPpjUYNqAPI6k2geFEJacIKnsv5a4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TXEbB1eUVH8L+Wqj3NukzdLW62EdATs19OO06AS62AA7UzWjrBUAwca31HpTr8qEllkXGun+KRTffmPkcgcE/3ElBggV2ebDTP2vsvad/oXCRyUXDN/AIZmFPOizXnNV6w+jcChXuRoF26+mckDfLcYpa+hV6Z6edCSo+JVsMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nlop4bDN; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nlop4bDN"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-435a16798feso7420175ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650367; x=1764255167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=Nlop4bDNIOkjuo0pMhzaqc0ODrEsmRo7XtLqwhp00uyFASxw+sbIvvfDKg63/0WNIr
         Irgw7i1L5c7f3KspyZuRfY76O51HffIuodvQy5ZIcDN4No7WwIxUOGZ9dpes/M6K+nsd
         SNLzENdMcdkRpJUmuFjuM9BMlGaR61DPmsUMatu7aVJzbpi7Z/RO6GbliOgOscpBha8S
         DnzFtV5phPRpPEJgf98WlMFKyzL6CdLykV3ZnkTgBAq3ZRb9M24771+6fglXYKmcEHuj
         JwzMwrRMP1iOEu/PZF6XSo/nxjqLzdvmfaif9TGvKGR4YXIy2m1LIpokuAZvSHGS7C+s
         olCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650367; x=1764255167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=aqffkidvqPBRUJneEET9hJMZ3HzCGUPyZuzQjNNNztwydGYRk5qkD53WFSCofrCZrC
         EtmVvW3/znxsZQYWTJYr7nyFIoN2TKV1i3HFiXWJv8LTaoznej9rQuGbFNn3FB4MtIDz
         cVsQp9PAKlH05rCTe8Zie3O+M6nCzFtfpkLYWKM7wo/K6sXQEzO7r6Iz5PyQajwtb4CK
         8lknTm5dnasiI0fL3bevo1/GS5aq0fMu981n2uxWMi5Uz3M332eYtVcaffQrXiY7lsUq
         yXysPm+4+3p6Jb+8ZwXyd3j1seSzPrujc5B5zskBuJzHEQlWUzpsR/FoOqcepHpVWPsH
         EzaA==
X-Forwarded-Encrypted: i=1; AJvYcCV+PsEG1S0Gn02877zvibmFVS8I/YlDku302IwJADqOyZhqIUXfr5RNiwNDIgD6EHcTrUJuAId8UC/LfHtMDI17@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKvtBf5w41SnTVg/0+FhIchgJ+6kPDQe455oQM2lyPl9MKrgz
	NnBUxRSnvHN6eCAVHyM/CXQLLgb4vmxncUmZCh3B2cu4kQPSzVuJzFHnywt3fa7YMoM=
X-Gm-Gg: ASbGncuTWvHRNJp1Yj94ULuEphueEmSwT1BHFDUQntTzTpnjs2r7ir57S7ORYtZjIuV
	ayicLyLp6Hx0FsihRA8wHNuRvkiOtRZOUH+eA8mjjhLUxFRjGeXOLnnwwZVs1/r40U1X4rMolW6
	EOg/eK+aXruf5HVSwcUgfdDMlDbydICA9n8uznexJ04b/SzRN6iuI9v1ww+5Cu3ZCBDZ3EFUwsH
	RRqr7kTHWOS7wqYZqV9Ya0qCnpWpKwO91CsFZFeocdBkaxBsZTHj7L7A5wItyR0y8xELEBsPUM+
	dsVr1FkRNAi6b4kv/PUanE0okDNRO2GiZRvhBSG9lJNl04bKjB2WvkrQN/Zi2i8bWiBq92zhfEh
	AOacU1aPSVsu6DXCp9+XNnV2vtopVsrr4lMYHkrzntbDv+2fggXmeIokydjfZcOsCVnYtZiOEVH
	tNWw==
X-Google-Smtp-Source: AGHT+IEmRlVKCe07qbgo1t2w3uFpBKsqx62crTftDC+8sZ0oUBIrcGL53VTRakva//fmnWvcfQrQww==
X-Received: by 2002:a05:6e02:1c01:b0:433:1d5a:5157 with SMTP id e9e14a558f8ab-435aa88e822mr21434775ab.6.1763650367018;
        Thu, 20 Nov 2025 06:52:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm1008611173.33.2025.11.20.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew@lunn.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 John Allen <john.allen@amd.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Mika Westerberg <westeri@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim <namhyung@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, nic_swsd@realtek.com, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Olivia Mackall <olivia@selenic.com>, Paolo Abeni <pabeni@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, x86@kernel.org, 
 Yury Norov <yury.norov@gmail.com>, amd-gfx@lists.freedesktop.org, 
 bpf@vger.kernel.org, cgroups@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, 
 kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-mm@kvack.org, 
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, David Hildenbrand <david@kernel.org>
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Subject: Re: (subset) [PATCH 00/44] Change a lot of min_t() that might mask
 high bits
Message-Id: <176365036384.566630.2992984118137417732.b4-ty@kernel.dk>
Date: Thu, 20 Nov 2025 07:52:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 19 Nov 2025 22:40:56 +0000, david.laight.linux@gmail.com wrote:
> It in not uncommon for code to use min_t(uint, a, b) when one of a or b
> is 64bit and can have a value that is larger than 2^32;
> This is particularly prevelant with:
> 	uint_var = min_t(uint, uint_var, uint64_expression);
> 
> Casts to u8 and u16 are very likely to discard significant bits.
> 
> [...]

Applied, thanks!

[12/44] block: use min() instead of min_t()
        commit: 9420e720ad192c53c8d2803c5a2313b2d586adbd

Best regards,
-- 
Jens Axboe



