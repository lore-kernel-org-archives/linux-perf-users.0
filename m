Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A63F164E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901387; cv=pass; b=LvpeYpaxRfjnhg1Hjpz1HxgPzSHDb8vOtrodhwNRNOR+5OmGWoR770lofDWNL7aki8fe6Ylsqvksonz4usMrDjCcHtByOf5h6THG9/F8eDhw5AYK3xQdwYl8PPSvh8jeCdYflMV/U8MZH8yAV2IAfUtdyu40O3olwGtElWo3aO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901387; c=relaxed/simple;
	bh=yj1sNd5vfDwsYGQAjFz2BvWzyxLrHMu95FMIsFy9jGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3de+U78nHRYkvHQmbnT2kw32QH+H0miuZcq3RJVYDtG9nmXc6ZQGJ9GMlkRLzIbo3mzs6b7jHxanzraS1E6DYcEQLboLxdfNx2f4vYuUzXG/GTSX58exL+IDOEnlEJmblMByh6u7cnMGGH0Fl9H+dS8w1ls2I8HExJBQC23MPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QwcrkcG2; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QwcrkcG2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e7131b94eso264349766b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 07:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791901383; cv=none;
        d=google.com; s=arc-20260327;
        b=QQy0MSK2ZBRBH778D6oX+tRbxc6DBqsFdixW0tH0SxDvQpVuH2ln6BCpirwzktGtAh
         zziJpIJOMG7dkmDkPssIXDqTNmRQjdzjNt/Qv4iRd0HXsNBCBgiQiHrrZeLASDjTKrlI
         +c5o26aMzNxFuTDbu4guYwhDKL/TvvIMnGAS2bSXcCBbSfGq63Zw0Eyjw8vufMiqnGO7
         4lx5WnlL6fbLVacsLhr8JLW+wJ9vaOe/+JTzxHd7Rg9MLnLpeIzrft1J5DQzQCqLT9jp
         PpKzVeGkKg+tPeBoxTE1p2NsiVh3yW25AM9Jghm1IE3SUfz+vmGQ+XSzZHhxr+9fcXdx
         AsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yj1sNd5vfDwsYGQAjFz2BvWzyxLrHMu95FMIsFy9jGQ=;
        fh=Wn3p6i9lZP8mCeEoATi505Rq8zp7oZqrkHJf04IoQNQ=;
        b=hdZE+OCMDHHk+KWxp8OOCzFf8X709+M8zwJAj6PeNru3jJtVx6OW1Minvhh9Byh/yb
         0nHKgWBW5sshT4S9WoJMeBf1rpoqLgNzylvL2rdLfjSGTK7h4U9p06H3o4MClbc3xeDJ
         RFRKaVU3I/BPgBgZzCGqZmMXMAR2daiMVemDrn4+2jInU+bIac3i0n7iJUCib268V5j5
         TyE2jMcRaScjJpANFMxyHZuhU3adPg6tQ7usLwzJjBFsI/GJd5fTGcmxHW4Vn90JJhO4
         RwFuJl7yBuJjrJGtQiYet8OEdwdGDS8hYqG7yyJMJHlskbbGhAClghYUwFfBIp0j2Kgf
         Zkuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791901383; x=1792506183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yj1sNd5vfDwsYGQAjFz2BvWzyxLrHMu95FMIsFy9jGQ=;
        b=QwcrkcG2qPqojWS8zrmYqjetEMN/XCmC1Cl4IH9j8p4MWaKhPsNhEVONdUInsqHDWR
         7aO+YJwuoCWNOs1GhADMB5Gm9Xa9nU0+F1ALQwHy5G/9+8bRuafsD/Yp4TrenJOovLTv
         hOA9n0wfnIyrZE6MZrOSiFItSDkFcGYH/cUwtvB7Y8t2o+JsvPEPjujfYsJrjHQ8w1oi
         p/nOBq0UY5msy45MvU0aOumovMJf7ep1JoCSIR5ywPd4/0nl0cMjEJMz+ISfrOsPiTJH
         SZuEbRONEXjgavXVCuIsFHLmrU4u5bXpRjrgpRgknreUkjs4bMcR6BSky2Wzn4c3er3m
         N0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901383; x=1792506183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yj1sNd5vfDwsYGQAjFz2BvWzyxLrHMu95FMIsFy9jGQ=;
        b=kIxzPigeXOG0d3pyellbvUIriTuv1txanNDhcB3kGcyBwzQpZKnlruquFYh6D0tWeH
         aafFNe2Z78zx9HPuB3MZXJNk0WCXzoB7zWT5n7Sa67SyVIh1uA4ctcVu/nDc39fIRqNl
         UPbMpYMD/Wl7ItaLS1wZykXPgxq3eZApzqYGKauvUOQbRS/rfBN99duVk+8zIFSAokpk
         YfIxFXJ3Y4UojeblI/AZWAFpiu1lorZZ+3CjqHpN/NnD9gzGkczKHLriVlDOJr0/ZCaP
         ktNy8sO3JpoxFHexUAjAJeY1VDb+s1XWZKJa+wR4ihWj3PPVXDKT15Y+UxYWviAyfa87
         3gew==
X-Forwarded-Encrypted: i=1; AKwUvBwyCxv8sU30nvtAP3eESgqZ/6fItLnw6O2XJSG3z1Wl3DyfIVrjRUCFUAziZxARhKq3Mss77eSP/v3rTrrwJ80y@vger.kernel.org
X-Gm-Message-State: AFq9FYL1uHNxev17ykd3pWFbD6VRcai7LHE3ZNEVMfasoKCmjbPNd2Sx
	0nEeki7gcmXoovvOLRNao6CR7wbOpWWFZTpfpKh96p2ECG/zsOU6RTHm+AI/gOIdMFi1N9EHnao
	/6AYjgV3Wf9uZZEAS7pHIEI8oSRgLHGTzReTIJ9LYCPXxjtNw5xm/eqQ=
X-Gm-Gg: AYBFou3qy4OSr46P7+l7RHerGi0U+aYk/1GkS9lHgcTG1Hn6K/NMLH1Cy6YmMS8Yl8q
	ZUsqbJ4taoveywCV98HYjbBT/4NX0sjYk7ClMK6pKlRLiwQO0JbFJKEq+4lFyHirv+iXUuGWt/S
	jConDfEjqU+NU2QhaBqER/RTr4WcvrGbhNd/pScLf2IgO4QZ9SvZ2Hq5hMyegI9bXPHIpVd6q0t
	3+c+b08P/u4q0/xqKX1tv04z7KkNGyNp9XQVo6uEiwRJJSAzvhzFhpVCFjMOvt59tPmXEdNPwWB
	wWTl8g6fKE9jdG/4N/A43uzmmvbAJ8IXb0tbbXgkgs2ULOpBE5CqBlL7FEC/JdDZLlrNAeRM+p3
	UawssycOj
X-Received: by 2002:a17:907:3e9e:b0:c31:5918:86d1 with SMTP id
 a640c23a62f3a-c31a9d3cfbbmr1362282966b.10.1791901383415; Tue, 13 Oct 2026
 07:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013130052.3012773-1-max.kellermann@ionos.com> <CAP-5=fVPtjkxcjEkR9r6QZGsoKe=_rZssjZp1FcJ7rCgntpPng@mail.gmail.com>
In-Reply-To: <CAP-5=fVPtjkxcjEkR9r6QZGsoKe=_rZssjZp1FcJ7rCgntpPng@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 13 Oct 2026 16:22:50 +0200
X-Gm-Features: AclHuK_BqQBC6qCTnYjJ1k0Yihq79IRdPnmJUUQAMz5lu8h5Keu2RPYrrqjpsQQ
Message-ID: <CAKPOu+8NB8sGv__CazGPYY_uEmg84-+YHbS-VOw=4woAZcRKAw@mail.gmail.com>
Subject: Re: [PATCH] perf: skip unnecessary userspace map synthesis
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> Why do the empty list and dummy case need the
> user mmap events?

I guess that's a corner case I missed indeed. I'll fix that for v2.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
