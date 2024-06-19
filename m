Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2E7E0E8;
	Wed, 19 Jun 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790189; cv=none; b=eYpk/qFGjQ3hrGILAk4qZwxT6YqmQMgj88K4EGKGTkc3uj+SfMWlJr2bUwrBCh6D2TkTFzY++bYego6BiNaGXSBzQaGuS1PAYbguejC6EYmOOXdzFPdms7f7bE6gyIRUBZ2r5SkRRvZ4J1GvPf5qMu+1bO16TJHJdr6c6sEhW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790189; c=relaxed/simple;
	bh=aZcdD80xbn04Qz+cNGRdLuHhLnsme0u6baddM3XmpbA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GD6I9FxmNufe1OPi2VirqjHBTW3v6bkKnGwJ4A8lPNqD+LjuUgElumSDIFz3AZJCIXVi8AKyXkqFu/JC02ZyJtvIWA1DL+udqX3jR8ZYY4O05sMFS+2Bjh1znS52TLvUvF+eWw70729KP020aXrlWC2W3dYCDlg0kcC8hqcKl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9pUqj1A; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9pUqj1A"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so1112071f8f.3;
        Wed, 19 Jun 2024 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718790186; x=1719394986; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCJBFRgC7dhjA/5UK7yuJPtSNHOo+jKxCkigNbHdR14=;
        b=Z9pUqj1A0QxZIKaGOD1RR+BWOZH4PFuu3YubGb8ETbJv+EIMw60tnBUc9jaNDMUICB
         g6kAEwVOPBiDXQr1fZPLJx3EhAA1JU4xMn43oVewLBBFVDX4OVMlcFREqdLLTHwUY0H1
         QITguvPun7iWJsvPqn5VfolUa0qL+IagCz3mZ4RNzuJjFuq8rk02cGw6dNpCKpFkMsBx
         r8GyBgC5Woj+3rcWdbzPNrzOFMyeOrmJcAOy4/OOtv45xCtz7pZsoyLcdJ3XN++cTC+S
         jj749j9tSDfM3O/OW6HcAZUN824Mw0HMtIXJ5KhCmh+WF1/J6AQeB3sCmeBOhjucbMPz
         LcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790186; x=1719394986;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCJBFRgC7dhjA/5UK7yuJPtSNHOo+jKxCkigNbHdR14=;
        b=DSJS6Eejh4XyiMGf07pwg93Pq3zJjQKHIjetgLHqhOo6dyMs/DCf0EJJUB95oiFlY1
         z2JbyNwHhq5T779pcd7PRJp/FbN0n185d/ZD/tI19EuH/AklcFZi/D+pWR9hJpRDcjhY
         gLPlRrZJVAvq4/7oq8dmM8fBnnms+/Uj1wm1ylQLH1JQbYFv49Kw2HA4MJOVkkRWZg5S
         uNflDv2N0P40a86tFqpl+I53P8cuID6k1WuZTtPtpM4afdsw3lYhjYpcuubJMPsOQaea
         UkfeSNEcbVs1XPr6EEeBWlg/Zl8rekx2wES1GXAdSQarsj3di6/m27KUSs7JeX/R7lZ1
         MBpA==
X-Forwarded-Encrypted: i=1; AJvYcCV/dWspKqQhWaSXmrybeJh86bLbMgqZquynhDKO387tQA/oNKssosoFi8U9X5W7eSzOhd3BB2R7FhYy3lSzR+QLC9pdRsUAD+A8DAGa
X-Gm-Message-State: AOJu0YzDxXL+J7SjE4FXUbKrhMm5mbVZ8iXo3+remcmj7HUTA/D9T5uT
	ZAKsPUlbSvhFesvH1spzfMAZibLJWWdjwTBop9vlq9Ac3B420Fm1
X-Google-Smtp-Source: AGHT+IHfD5af5hdaDNs0EkYTxzPlwFeEXIqf5gMtquhsrtBjJywy+yZLm14JFilHxeeGZ2DpzQZM2A==
X-Received: by 2002:a5d:4e0a:0:b0:360:81f8:698 with SMTP id ffacd0b85a97d-363199905fcmr1436861f8f.58.1718790185700;
        Wed, 19 Jun 2024 02:43:05 -0700 (PDT)
Received: from smtpclient.apple ([93.51.30.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362231c7ec0sm3765657f8f.29.2024.06.19.02.43.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:43:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] perf/x86/intel/pt: Update topa_entry base len to support
 52-bit physical addresses
From: Marco <cavenati.marco@gmail.com>
In-Reply-To: <efc3a224-27b3-4259-a9a3-0296ccbf3e8d@intel.com>
Date: Wed, 19 Jun 2024 11:42:53 +0200
Cc: linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 tglx@linutronix.de,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D68A619B-B9EB-4E68-82DC-9CA68BD082FC@gmail.com>
References: <20240618110617.22626-1-cavenati.marco@gmail.com>
 <efc3a224-27b3-4259-a9a3-0296ccbf3e8d@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Dave,

> On 18 Jun 2024, at 19:59, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 6/18/24 04:06, Marco Cavenati wrote:
>> Increase topa_entry base to 40 bits to accommodate page addresses in
>> systems with 52-bit physical addresses.
>> The Base Physical Address field (base) has a length of MAXPHYADDR - =
12 as
>> stated in Intel's SDM chapter 33.2.7.2.
>> The maximum MAXPHYADDR is 52 as stated in SDM 4.1.4.
>> Therefore, the maximum base bit length is 40.
>=20
> This makes it sound like it's _adding_ support for larger physical
> addresses.  It really was a bug from day one.  MAXPHYADDR has been
> defined to be "at most 52" for a long, long time.  I think it was well
> before 5-level paging came on the scene and actual MAXPHYADDR=3D52 =
systems
> came along.

Thank you for pointing this out, I wasn't sure about the history of
MAXPHYADDR.

> It probably needs to say something more along the lines of:
>=20
> topa_entry->base needs to store a pfn.  It obviously needs to be
> large enough to store the largest possible x86 pfn which is
> MAXPHYADDR-PAGE_SIZE (52-12).  So it is 4 bits too small.
>=20
> This isn't the only bug in the area:
>=20
>> static void *pt_buffer_region(struct pt_buffer *buf)
>> {
>>        return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base =
<< TOPA_SHIFT);
>> }
>=20
> At this point, ->base is still a 40-bit (or 36-bit before this patch)
> type.  If it has anything in the high 12 bits, a <<TOPA_SHIFT will =
just
> lose those bits.
>=20
> But maybe I'm reading it wrong.  If I'm right, this malfunctions at =
pfns
> over 36-12=3D24 bits, or 64GB of RAM.  Is it possible nobody has ever
> allocated a 'struct pt_buffer' over 64GB?  Or is this somehow tolerant
> of reading garbage?

I might be wrong but I don't think this is the case, integral promotion
should make this work fine with no truncation.

Regards,
Marco=
