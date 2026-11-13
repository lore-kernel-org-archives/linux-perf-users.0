Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587712;
	b=d8TDqTsSWa1A5H8fqN66uI6YAfxk28yG6ba2qhCORt3SdyVR/BXx0N+oJeJ1ntiF75Nu
	 vOgQATZrIMmwOkleLEm3DhBqOwlCPTnptsV5XT/Cv2HjhvSRr6/oxS4U1kARjLB2G6FP1
	 iZ1DxHnR8zY/4hEL81sWqJp2XMSKG/ZATwFordP8heJGvGxYltgEl5lq4Zd5O23SIu3B2
	 doPkZ9+11HsDubkPkkTEbrkkO3DhcRJXV38vxo6+Xks3LK95pHckKQRh1GpQeOEXjTsxF
	 LzlY6slho3itw60zaMkaQhLApNBfcS0XckEzon01zD+MJ5R/t2JNjW2IsRf+PvjIjkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xrD29yEt3//vypzd/WFZNa9lHxGVeY2L/1gSF8kcYKk=;
	b=kCeX1Wv+D28B/6LZ3x0+VOu7K/8fYCiX9DoT5DhGLux5SnyoBcSPqPQME/c9Q8iV4Ri1
	 EWMdtqRAGdGLrsmCUKULpaUt8YiDjZdLubBr8ry/Vm/MXfnRpxItt3MMknnG2QJWy3QgD
	 TigRf81hA5JqpWDBrSgSKD4kDiKjk4pPZEGg/Onn+y//lV9hAfzLEFnLougSWnsvJUE6M
	 376gmW11BdQIgpqCTx4erff3Ej5UnXAx9nIrdJhWVyoS6daYIvzS7TF/YGlqhr4vdZV9X
	 wx4LTDj8nCtr9q4qkl8doUFP1/VJh0LtJgplVwed8t3y7cViJUpW9j/j5mcljmU0GXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjZkwKQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46146606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46146606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjZkwKQw
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-54492d8a988so458811cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:35:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587711; cv=none;
        d=google.com; s=arc-20260327;
        b=FSBfYrnKwPJDjPytKLzfo9UA4in+8C9pZx9kVrcsU+ZzgM7kG3gVIU1WPK/UoQwhKM
         vw4UH0OT1N4yBDkBE0/1U63+QieArmxKHyDh02haNhG9s3Vt10fbTP7SkVGAh+UHAJlX
         47OXA8Jrp5omx6qEOs+1ynpvds4oRnXa2tnLhdM4/Wy9lOdSPnLfQrieDHvd2nTM7tWN
         Ii9DRJb+N2guV7YTuQ4CXBOQ+o4Z7fJspHJdAgQkNSJTd3AQwckbPC15Omw8JgVZbJjs
         DMveukvqoDaXpYv8TKTulsjrTJvFh28RdHr9Js7HcaC8mvZnPx6nEwq/inXe2TtToJ4X
         c11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrD29yEt3//vypzd/WFZNa9lHxGVeY2L/1gSF8kcYKk=;
        fh=QN2ARsG7DOhcV0dM68XqDzH70gtVLt76TYirLGMoM+0=;
        b=Fhz8kdsWHou+2VnRsXQJu2BxtA3tjCQ7A8SGSHf9OdT4SllQuQIBV50M9IXs1pZmDY
         zMEw8OKZdeUkh4UcFrT8B09ekqGp8yPPZXSrbzbAMh5eQCluOJkxr7Wk+UlBwcUwuEYv
         3MoTOzbJclJZT1aGqQ6o/6U7Kp9H9MOF+/QbNowuFR/2fF58uGaNwvOA3Zpn20OeI5Xv
         8zrZ9rRqcObIinWLE23CNjjcARsLPi1nCoNi2xsR4A7+6Ohp0GsSEzWBSPl2EkVc3Tro
         H7Q/gX+opZdMA6uY7JTXluNE/jeE9eQaT5H5VewYzXZwkz+5VDvsxwizdMd2cnhNR59W
         F2bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794587711; x=1795192511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrD29yEt3//vypzd/WFZNa9lHxGVeY2L/1gSF8kcYKk=;
        b=bjZkwKQwarfQCokl+bReY7YfF50Xxtjoqdd0QOvCX76RT1KRX0mKFan/bMPKql3RvN
         dHVzSEcOIXLorbkJz9imLGgsXS63UwQhqSiQ0xnubEQjksGFBwLRL85cUj2aHDPCYc90
         Yi0JyHsfiUByilFI/7DemKLLmJ1suBzQj7XdERvzgN+VGW7R/FlVqKTfy5g065sPk1P0
         9EWs5k8Pri3znfXL9l8hOwkbYUTilLjX5OOzgQcJ4LhjWjp3n41ctNfCVLG9WHMcspzO
         QHxEfIn+jEugkeal06YEod4E0LHsDnWH5ctf6HZGQuvPS3Lnp9zsCIw8gfwwxmaEFTIy
         bTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587711; x=1795192511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrD29yEt3//vypzd/WFZNa9lHxGVeY2L/1gSF8kcYKk=;
        b=w4n0DHI2JVFP2qs7b0j2cQU8T8Rk8VIwb1mqHWsqXkvSl3NhwBjD8fThwx17Tyam7T
         tEYRT49yayZX1GQgsyUOLC6+rK8rNlpUnz6wYDcnp5vOWlSK1OJLF5MMNUx4h7v0dtKZ
         Jop/Djvh77ljQ4fz/HWTyO7KHTDDSdLdgQGLdOjGrAJNu2rTs2nmDXDvTUZm5qkmRLAP
         TBm9aBXii0fwHWIEZbvjl8N3m7NYZcBAwtbgnYZvyFfzjwCDpJSn4IINuReSHdg9z09y
         hEhQz9Ys9jZHeP3tIVG5x4Q5MciBcfR2jv/3UOGmoQQ8dWuaMKCt+TFbqWI6jo9kdMyh
         GA9w==
X-Forwarded-Encrypted: i=1; AL+hErEzezYzFrGkTJLVlfoFuQpnlJACFcCG7f3mLnebGAHaSpGN36eJgoOlxI83G5Cveg3mCGyfeyBvoiYk6zZIu8tD@vger.kernel.org
X-Gm-Message-State: APuU4Z9SeVyCdGCwYxvzqAoPv++ILxci0XAdIckV0On2z/qxW3QVdfEb
	MPFTZB7e/8XpJvB7SHhJUgODQOuSQZBUR7icDynWTjS/KkDT51WJLq500pJeTWawML3rr210mCU
	2UN1vvNtj/nz9PzGby451L4ptdi1sAAgCyKwmpW+kZbcZI0OxHzRLO1ysFKs=
X-Gm-Gg: AYBFou06B4jY2EWNY/9kOSnRHdLQvoxx6zhvkn7pV4AyLqHSwfh5/3F/5UfGzPg5DOS
	oDvKETl6/+lLkucF1wrEn+IIbeB/LSz1FowQr5qgp0rvgJrXpiM02iHfLADqB+BuTkqTO/LLb6q
	QPiEUaKCiNTVmyrAUN3hiyHx7Mnquhf1jVHOZvZn/9cbNXLzm56ktbEzHiZSEFvIcAslxYuyKnI
	c3V6VUZtaFhWL8MobUcOIZ6pVYHCBw0NPxugHC6awLcdBxQFamTkAaijRUo/2sQhPg3uWHkpVy4
	vUZ3yETDmQaN4BnOH61Eo1aNNn6DKqzldoAODRVSHwh61YCxHyiNkIWBOiZ2aw5Ye1nNcmun/Jb
	FLpKwOiEwQ/p48M7XqsF/9Ykr/9v3Z2XIX6yG5/3V5qXEwMKprHbM5hJQfCSnNXf6tOs=
X-Received: by 2002:a05:622a:1ccf:b0:55b:ce7e:e65 with SMTP id
 d75a77b69052e-55bce7e113emr6611301cf.12.1794587710393; Fri, 13 Nov 2026
 08:35:10 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com> <20261111174213.3526604-16-irogers@google.com>
 <avVoe_hajXqJpfmq@google.com>
In-Reply-To: <avVoe_hajXqJpfmq@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Nov 2026 08:34:58 -0800
X-Gm-Features: AclHuK_7fmidtjnY23su_Zqg7HL7UTKU7Xj3J_Z1_BDHCkhGqtFv7HpxmgYMpYE
Message-ID: <CAP-5=fV3hTWRH3B=rZ9LQeubu2mb+caXyQxdRtAfRtYO7PCA6g@mail.gmail.com>
Subject: Re: [PATCH v12 15/20] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 11, 2026 at 09:42:07AM -0800, Ian Rogers wrote:
> > In tpebs_stop(), read tpebs_reader_thread into a local variable before
> > releasing tpebs_mtx to call pthread_join().
> >
> > Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it
> > as the thread argument and setting tpebs_cmd.out =3D -1 in
> > evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
> > by perf_session__delete(). Also reset tpebs_cmd.pid =3D 0 and
> > tpebs_cmd.out =3D -1 and return early if start_command() fails in
> > evsel__tpebs_start_perf_record(), as start_command() closes the pipe
> > internally and may leave cmd->pid =3D -1 on error.
> >
> > Serialize tpebs_send_record_cmd() with teardown via tpebs_cmd_in_flight
> > and tpebs_cmd_cond, newline-terminate control commands so consecutive
> > writes cannot coalesce in evlist__ctlfd_recv(), check
> > check_if_command_finished(&tpebs_cmd) under tpebs_mtx only when not
> > stopping, ignore late samples in process_sample_event() once
> > tpebs_stopping is set, and guard evsel__tpebs_open() against a
> > concurrent tpebs_stop() with tpebs_gen, tpebs_enabled, and
> > tpebs_stopping across closing the fds and finish_command().
> >
> > Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, an=
d
> > <unistd.h> explicitly.
>
> I feel it's too verbose and not clear what's problem.  Please explain
> the race and how it fixes the issue concisely.

Agreed, the commit message grew unwieldy across revisions. In v13, I've
rewritten it into two short paragraphs summarizing the two bugs (the
tpebs_cmd.out double-close/leak between __sample_reader() and
tpebs_stop(), and the unlocked tpebs_reader_thread read / concurrent
open-close teardown race across tpebs_send_record_cmd()'s unlocked
window) and how they are fixed.

Thanks,
Ian

> Thanks,
> Namhyung
