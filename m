Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86238E8AD
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113191; cv=pass; b=QJLvSuMVQb2xy89yqzEnSQSW2Im5nG7e+0NZXwmAqsYcBPqCkzcfM98T6mOByvooCBE7mjYAjbYswx8SvQaR+jCp6obQjFPxVrvIXJ/i8vfcOXfIFq/UuPXuLBs5GaANJchL3IngY5jCzvU/Sq7qJJEl/s2C435YzpiNNjkPdnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113191; c=relaxed/simple;
	bh=YccBFGTTYtE+pByX+TnsqBnpsyvc+9fDzsZqfxshfOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/aba6ICCCJN99rpTU+iszjo4qBASRKx+0IcPDZ1E+XByTE3TlfI8SFjCy0s4V+iSlYHI4z32Ys+YOwzW/rQLISs2jXMTznD9f3vG8S00oDWCTXCiaY71fKfupR6dlMI6JYCB05xu3eyWL6veio+t2nSEcOsehe3oW5GWAFAXvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khORmEYz; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khORmEYz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15cd3fd760so374848266b.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 07:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113188; cv=none;
        d=google.com; s=arc-20260327;
        b=AzkS0tKC/9kP9ozir1tM+wyEMfiUFnqptWwlXNmYPunwIJ1DywhYpJDyPk9bCwk/Tk
         URofB105xNfCO0/jSmiW0DXexuC8JedtSbTilSuJSYZsegMj+0RcWA0VMBI8OoEeKgzO
         F4fRQCPVwgZUUCrppEc+GXwqj+SFcmHO/DrwyibJVlljkc2GeFY9DwlA7GIGzeX7vmON
         UV+vU6rTfjZiBfLRoqxp8JdIgHGEX10Unh6IkF3roHGpC71FXahAbjvVvqXH7ww3Clk6
         xt2NddmPgPD3WghVJmnAQr8TNKKfQpQRjEc2jZVI9XCeJF+JtZMudt9TLgh7PPLGLV6/
         VdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HpOmJpx/ADqA+1gbMGirD4LpSKVgKnj37zwmvfF6jPY=;
        fh=aGJ2a6BHbMPrImgWCrXbEoHg7fhrz5XA5tI2g5TEWHY=;
        b=H5eTxgr+QneOdp0NxSlxGb2nYjl4IE2N1AdxmIuZmZb/txsIcV7gwA0tOwQJLjdSoz
         u+AcIlw+/m8HCnQyh+pmew9mZfDl2JuyDvhjKMSUb48GONqaXFRrVHwmzKPQT6il1Q/Q
         VmwDLga1EnqakzrQZv2zNAlZvXvLI7n3c1BpfxZEFtTP+sDXV/4dcdXz1+CKG8nDypz6
         ZR66KA8El6B9iVqRNQuEr2UivRZUUKfCysFYMlz7HGPzX5IwGevBWNMWoVzKf6q2a86b
         bkPLEKpU16NL+yuJXNhNVmVK7+d6s6br4c5jIBr+W6TRulL008TRMr7/1IUwPAbQiH7u
         Q/yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113188; x=1786717988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HpOmJpx/ADqA+1gbMGirD4LpSKVgKnj37zwmvfF6jPY=;
        b=khORmEYz+b30IPLjLbHSBbBqMdsRPJe3/BqdTr+MId4MJJwUAczNoL2myoRytt/LHf
         cExp517N/G8c+Mz/hwlP6convcp5ffCKH3g20zHiRHHT6ixlnPnOZGb5cAtWep8VfZMa
         pR1LEWFFHYLvuFB5rjVYJWvMkfFuU0bTdu0JJvG7kDyBaxBpjyBKwQxke5Nc/5D8WSgX
         azcHoQWZJUQKWJSDlq7CqKLTpYH9qXjHnUAN9eL57dI74i9EkLOhfAZhdROZqZXF4sGo
         v1s6TXU/WFUPg5ADdspjj9wMK9wnWwpzCjorWIc47GAI5TBVS1zNc3VAzImnD60K62pa
         N6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113188; x=1786717988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpOmJpx/ADqA+1gbMGirD4LpSKVgKnj37zwmvfF6jPY=;
        b=D3hWw/j81atZzzoPJ3KZhZV5BgLNkrhRr3lCGWVZzna9+CfXz/B+ENFhg5V5ZFjW0o
         2QBB0QuGHD9ymHcXqGFl7DT/Q3i9MLtCmDn11K7xDrNViWoiUa64O7zWlVD8F0xBrj+I
         /7mV0qcwpqyS5UPS/XQfx/fxYLohpa4n5+dI+9wYbs3601CEYxCGc6uJac32bjpVAApI
         kOe6Qj9rqqYXFIiYTeLk3xy2M1p+2YMquooMFriC6+rwqsWfZX9LXO15IqbDXmH5A8G1
         HBD3hGYgvLXKg7ic9xTgKRAyqLHlit9xncdo1T+eRgCl/n6KeO3gil/ErghqnAFpsb2f
         TUPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrlshzkcj9gKGBLgyHa6o6YDgoJDvRbKDmit54gXuPXNcfjqi6uiwRCMGMgIuKeiB+kcGybT/uFCZVa7oIJAUwf@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBoWxAij28Ft94GEcTGy+tMqvg7+uoYaVZoV9OjTYxEArEhCH
	c55SeQgGaprbJIDBsJvu/xrYg5WKsP84H4wUbf86MuwjMxfr5cO5fvFft3pXIPDB07hof8ah9zW
	XnqOFUmTffwsR1tRY3MwW5dInDr90SSM=
X-Gm-Gg: AR+sD12/IwSKp512BO/WEIuTJZMPLZF43XPlSRBGXR4kxaFmu6F6f42MGuPuJBGxVbg
	WLWzpecg0eGdJxfRCul+DA9MRhTUr42xe0jC9//iaUSPQwLXKI1EbtSHa/LHrCanigSDr6tBDs2
	8Uu7NwESRriRo8KvghI0JPY7u9w2KPBVKjMK1nr9hhN4yPXqFXdrt7UjezVbNzMsyaS/FTZczlb
	eA2M8/YSajzCZwijecZn9leo7JRZuCGkaUcgyd4WS/xsfFtmlrBKnAmJV8uCjRtzH4FJkXWl4oN
	ec8DV7bx+Ry3PjTSFihp376v8okIVZcnN8XuPoq/GRnhYye8PSI6m96mUeMy
X-Received: by 2002:a17:907:1b12:b0:c20:191e:89f3 with SMTP id
 a640c23a62f3a-c2039c563admr1000445366b.16.1786113187576; Fri, 07 Aug 2026
 07:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-4-puranjay@kernel.org>
 <20260807102932.GU776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807102932.GU776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 15:32:53 +0100
X-Gm-Features: AUfX_mxyzLraY9hB4bhCgklGOwwZVl4fSNPtqGoxIfRbh3s6Vi-E_Sl4h_YJMAA
Message-ID: <CANk7y0gxiQdKsGKrF2xhp5nS7Vc6zGBVVSb_US_x_Eb6vyZjhg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] perf/core: Clear the whole branch entry in perf_clear_branch_entry()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:29=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:23AM -0700, Puranjay Mohan wrote:
> > perf_clear_branch_entry_bitfields() clears the bitfields of struct
> > perf_branch_entry one by one and leaves from/to alone, since callers
> > overwrite those straight away. The list has to be kept in sync with the
> > struct by hand and has already fallen behind: new_type and priv were
> > added to perf_branch_entry and never added here.
> >
> > Only BRBE writes those two, and neither is written for every record.
> > brbe_set_perf_entry_type() leaves new_type alone for a branch type it
> > does not recognise, and priv is not set for source-only records.
> > arm_pmuv3.c allocates the per-CPU branch stack with kmalloc(), so such =
a
> > record carries whatever the slot held: uninitialised kmalloc() data on
> > the first pass over the buffer, the previous record's values after that=
.
> > Both reach userspace through the branch stack. Nothing under
> > arch/x86/events/ writes either field, so x86 is unaffected.
> >
> > Clear the entry with a single struct assignment instead:
> >
> >       *br =3D (struct perf_branch_entry){ };
> >
> > The bitfields add up to exactly 64 bits, so there is no padding, and
> > every caller assigns from/to immediately afterwards, so zeroing those a=
s
> > well changes nothing. PERF_BR_SPEC_NA is 0, so dropping the explicit
> > spec assignment leaves the behaviour unchanged. Nothing needs keeping i=
n
> > sync when a field is added.
> >
> > The helper no longer touches only bitfields, so rename it to
> > perf_clear_branch_entry().
>
> Fair enough I suppose, but then why not write it like so?

Yes, that is better. I will use your version in v7.

Thanks,
Puranjay
