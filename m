Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06411A2C0C
	for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051133; cv=none; b=m03KsKXCp8AD1+hFNMOnKWpoDXk/ys5T/20lTtVxPVRDOqxlaAokjZIV+/lBuxfn/ddUSFVRcs1CzqHx4rvBYibQ0K/sa1uJstJ3g3+JYsejO24SNIiLKWXbtMIPz/nTTeck7Y27oXh2IduUfUUno9r4yYgrDMUG0VDJGxmSKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051133; c=relaxed/simple;
	bh=l6YsEWS/ABcR0dajmEy+qG/E9RJM5PQOAXDnh47LfTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRQVPDBFZKOQjBPv48LqwxYfs1ooG57F34YG1UVbygjNK5me9dP4lq8DfT5f9SUXSmHbxPBegNlW043sGxNRHHV9N7znJFdrZfriGz5YjHQdF/0EkJ1ACpmkU49Sdjr5qJDFvhQtSTEYjVYmyt+E8VKz7kgMxiUn92xF5AbiArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ccjy8m6F; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ccjy8m6F"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52327368e59so3274048e87.1
        for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716051130; x=1716655930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6YsEWS/ABcR0dajmEy+qG/E9RJM5PQOAXDnh47LfTA=;
        b=Ccjy8m6FCgnMoGUbLIhrQ3iZ6So8tD/4xzyNNzgM9tsmGniJ48a4WCNf9Rf10TvIL4
         HRvnHzYlg7xqAuNiZlZcG7bpvnyjsaCDSbpJB8wOtHgOBZ2nacIFVe3XVD7+DY0tJpBl
         uxHUfHN/AhD8hLCuSMs2bf2dTeaW9hvaE847Vji5yAoL8n8brTRqd69hURhSjSPxT+T5
         K1FBosL/wHclxJ/K+0QfzkHiwyQ/vdD7HM5A3Wd4RrHe6dowURSCeX58oIM/H4uP1IN0
         oq0WKq5sBuRQ+ylvG0zafFNCBXhejuMrHiQ9Lv7rTqPrep+rQsbUeWUUsHF7fMt4jwgc
         hr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716051130; x=1716655930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6YsEWS/ABcR0dajmEy+qG/E9RJM5PQOAXDnh47LfTA=;
        b=oRzR6oSgLgIZJHhGqt8Np1BTjdh1Bk59Yrcj6z8spYrekw3ov0Bp9yr7TnqAHsByCs
         zYuqtFQxbRagoYWKyoZN7Z11CBdoeuCKfPGdifbAae2dy43MUut3aE8XRLgktHtcjfML
         Ingu/0P0kRnkR//CshAtNcVEQXEbC/V9TAYG+tc8ocX2AkJxYnweg40AZANuRJiw4S50
         baS7rXL5x118SKV36hP6iZj7BjhGeQ2X3zSIwVoHaWHVYSH07k/jnv+jVjTj3SO5T31O
         Kl0NqKCY5pgcXaklZPmtFe3XjT6/nuPdq9sJ2wAWtmXvsUgj8K/chT+RW3Y1GVpfhlz1
         ACSw==
X-Forwarded-Encrypted: i=1; AJvYcCWN98PfVyCtqMF5Gf9pdrO/ZkzULzQ5AWuchQP5dGxE5lu/4lKxQ8ruccqGryJOHR8rWMBWpHzJwjNHYUHp95HdhRoRQhItuNNiNP8eIZVIMw==
X-Gm-Message-State: AOJu0YzofoTOphjADL44JVMScG+XfADLZOEH3cUBghTyhsM7a6A/v7EE
	y7PsK7rBXLoS21eThbr06t0086HdGbaWDcSVP2aVutD1HmSaSdE6KD+G/KEFuQ==
X-Google-Smtp-Source: AGHT+IEaONjm6TGnUEl6G5UDm9CsvOyMuTbi657uDAjXBwrxmbicurMWwo/UVY1XueIWxmvwwGtSvA==
X-Received: by 2002:a19:915a:0:b0:523:90df:a9c6 with SMTP id 2adb3069b0e04-52390dfaac8mr6267029e87.50.1716051129591;
        Sat, 18 May 2024 09:52:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:8b68:8208:4316:d53b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3396sm3586068e87.132.2024.05.18.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 09:52:08 -0700 (PDT)
Date: Sat, 18 May 2024 18:52:04 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Support LLVM for addr2line()
Message-ID: <ZkjctIdmFZGrqj5B@google.com>
References: <20240517185426.3659651-1-sesse@google.com>
 <CAP-5=fVYvT5EmPDu8gYUPSB+GjHF=K0dvTq2wwwHKOg58LStcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVYvT5EmPDu8gYUPSB+GjHF=K0dvTq2wwwHKOg58LStcw@mail.gmail.com>

On Fri, May 17, 2024 at 02:27:43PM -0700, Ian Rogers wrote:
> This is great! There has been talk about the code being slow and I
> think libelf may have been another alternative for this (maybe also
> capstone). We should probably build a `perf bench` for this given the
> variety of choice.

I'm not sure if capstone can do this, but I don't know it very well.
libelf probably can, but LLVM has a nice advantage in that it also
supports, well, non-ELF.

I took the time to write an LLVM-based disassembler, too; it took some
coaxing (there's basically a C and a C++ API that are very different,
where the C API is much easier to set up but has some limitations),
but I think it ended up not too bad at all. I'm tacking it on to the
next patch series. I think after this, the only things really requiring
BUILD_NONDISTRO=1 would be non-ELF debuglink support, slightly different
demangling, and loading of PE symbols?

> nit: kernel style is no curly braces for a single line. If there are
> curlies for the if or the else then curlies should be on both sides.
> ./scripts/checkpatch.pl should be able to catch things like this, but
> it may ignore C++ files.

Ack. (I did run checkpatch, but as you guessed, it didn't complain.)

/* Steinar */
