Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE50537F2
	for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051274; cv=none; b=pfpL0eU3Y2ccOeNiFIrSF3vmMAF3g81fhcHuVWCQqDF1y66OkIyi0ytPhZO5jaI3kRXr98MfTBrGjJArr9V6oKBh42V9S45+5S8hS5KTNlmOqf/Q8z/SZq4/USX+Ks9DAConVZ6RlMvy1b1UvbaMwb7g9VP+BWTGwveIjiTWz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051274; c=relaxed/simple;
	bh=Cy6QgkzIvtwsksNyfer6Kzitx6I6rlqiDcesoICXdK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7MzJihWvzJRIAUV4ugQaIRyDi6a5ruYZwfU4S0cUhLa21bDxhD9Xe12EKFgNxTgilnlkNSi3M6BZL4ideSSvfipvrbtXX5dKM7A+xbNwT3gDbOvoSorOJTQxIK4chZjUwEnRElCH3XfVnqwwAeVKjHVq7ClXjxOchB0S/TPM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkEikk6Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkEikk6Q"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51fdc9af005so3113919e87.3
        for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716051271; x=1716656071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy6QgkzIvtwsksNyfer6Kzitx6I6rlqiDcesoICXdK0=;
        b=HkEikk6QlWpDqyAzvbLR5eEgMqXn/9BOPckhVKAOOBF+hy50fhjlK18fcGJDfk/2mj
         7wFWFmj9mxWOhfwueN6V/TdPxHJDc3k+lE/73tCbjzeMrG6QfeNE82/816NjzoksdZNz
         NWqfI1VAW3B5Qej5lgD2PxvoeD4Hps+iF13IIBhVHkHgLL0gCPKltPsnl2GDYad7FQjs
         RwROp/+FAvTau11RwyR0VM6Y2kdTqY1WyYDwqi/rWvZhEGdkp1W2CwpKbirp08lz0+lN
         x0xI0Y8pkN5nt2HUKNqwrqiWnmbz5WtlHtm/qxW0XDdqndE2LuJbcnejojvTqiFz69n3
         sxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716051271; x=1716656071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy6QgkzIvtwsksNyfer6Kzitx6I6rlqiDcesoICXdK0=;
        b=oN1vkwe+tpcUR/LF1xsXux6WFlnaq58O2eaFyOYy0xhhc4QyPsFraS0k1eSzRRY4wZ
         Jmd4/Ph5cnkyPULWW+yTSQCn7N18ruiaykS4R8gG+Ow1xbqH30zQmFp13HMUiBfOkuUa
         AVmuGbg70gnNPp2Bixc7zqMA6zNPLVmQWtsDK7h8/rorkeP2K2NdpYdhYR/1C53brQBV
         AzrrHVwDPa3GgslssQburRVtFs8kczxA4sjql1KZ43AM84OVNYHH2IIpkIfNuAq6Do8Z
         RPRteqzwm3x5cx8MhPg0HAOdALY7CeVfMR0LEkMLmbqNKlWFG4ZB/rUqbNmgYE8WCFB7
         5G2g==
X-Gm-Message-State: AOJu0YyUyN7TOJZfkZNVQs3aBDmJQwKJjHJxkFi4brLsgr/hkLKpLps2
	PSjcb9iysO8DJ4K/4Sv+FDKjflxAk6dkHFSfZ38V05CAnpZ0XesVl08qO+qk6g==
X-Google-Smtp-Source: AGHT+IEj9PS4XH++4fkHqJu7SFk+C3GRcYiC3Omjx7f7BObd1OIJALWJ4dwiSMIoyRyBJbodRxH4sw==
X-Received: by 2002:ac2:4181:0:b0:51f:36ed:ee43 with SMTP id 2adb3069b0e04-5220fe797bcmr18519511e87.31.1716051270699;
        Sat, 18 May 2024 09:54:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:8b68:8208:4316:d53b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad4basm3605671e87.59.2024.05.18.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 09:54:30 -0700 (PDT)
Date: Sat, 18 May 2024 18:54:26 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v2] Add a trie to map quickly from address range to
 compilation unit.
Message-ID: <ZkjdQqN1dPsZDDRA@google.com>
References: <20240518165315.3963142-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518165315.3963142-1-sesse@google.com>

On Sat, May 18, 2024 at 06:53:11PM +0200, Steinar H. Gunderson wrote:
> When using perf to profile large binaries, _bfd_dwarf2_find_nearest_line()
> becomes a hotspot, as perf wants to get line number information
> (for inline-detection purposes) for each and every sample. In Chromium
> in particular (the content_shell binary), this entails going through
> 475k address ranges, which takes a long time when done repeatedly.

I accidentally sent out an ancient patch anew; sorry, please ignore.

/* Steinar */
