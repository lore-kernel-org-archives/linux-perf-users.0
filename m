Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374383264F0
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570962; cv=pass; b=o5Dr/+kJ3DsnliAQaCBmVGD/UofRAKcnPw6NOdsGm3C3/l1AlN6AD5Hrz6iKtNSrfmXfb8X60Ejt2YVvF0Q1Hp7zDKVcyhgMTlLqTPMI6lVaR2/2e9aX3ovm4+uw8Dh5WHXbcIxkluuL6qkVd7WwaHkI9t5cumfHAVFEUrBRga8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570962; c=relaxed/simple;
	bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiIuPw3zUoke6J3Xl7J/AoLZozKk0IyKbnnhBmEPflj0o/2Yv4zbTLguPXYI4oV9qZYcg++17E2Kgr73MjN5ZDlzk/ghQvm4yPIqkeIVfaTTT6exXMKFAQ5fTtNZz9PFsLmVdw3WeB/h+5J3ED9H8G6gSMxn3C2U/nKAFab9uQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC/6UvpH; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC/6UvpH"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdff6c15a5so165079eec.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 12:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772570960; cv=none;
        d=google.com; s=arc-20240605;
        b=TtEO+d1gmuLV+IIErNMwviNyQGclQqYkyK9+yeYwO2NudKGHHZ4gTWZBP7LYrddBpw
         RnrEWsU4prSJvSQCzI5ybojZS0q7p3GSse8pVni0P/B/YpBQ4A8uNDhrzygQe1VWkEIo
         ohJHQUGt5PsfuPx48xmcY5rdX5clULM9yl2jLL/JgL85VI2NYFVGmu1503StZZJBacUk
         E+tikqGNjZaLqJFBMrfSJhHVm9W/NwhePJKkAJnEnFGuz+PyzqrF2EmeyHtpO3olRC4y
         FT2Ta/lx4XoD2IDtGRxS7BCEqFOVUNL2g6WnRaz6Ulo8lAmle6jjnJu3yPLFYRYoom9T
         eAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        fh=8qBnttxlbS0qXW5EiVlgy28Tc8uQINes8Dv9MYab1qw=;
        b=dZpT4HdACzjYM0mguo4L0qlTgFjMF+6esbh/NtAQfbpWp7NDWu5rtqofbbQUf8jPJS
         Gh9tk08rUbiLeWuUmUc0w5BIZoAwIkffngsBKtO0jEn6X8W/N8P119eflOAmcQFfD1vz
         mKkFAzWtKSiiry2R1eryz74d3KoIHmE6mumIIKgqzljEhJuQWxglRiM+qX3Z8lK9NeB3
         R9HFvxcbd3Dl/zecCyGQ3VxBDMSnpA2gN4XZQ8zpUTp1IOzES7kgej95WpmKS5eLoXKn
         40KymzwtuQfbPRriRyLT/o3wktCpyYP2u3yC/n4nbRljXNIMZs0QDHF9/VOWlIaR0eIr
         YMpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570960; x=1773175760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        b=MC/6UvpHT4SEnjb/NMu4nCD7Y/CgFLGhB10BzWPvEDjKvZA2lZ9okaGCUCGB3IbeLy
         cGgqGyj71FN7/CioLy93vdYXiKOMJe3vR+j+biXyjvWiP1VvwY0SpZuEnET7WI0E0PLq
         BBf1WqOSwDjAumUHPBfJGMcqZXc4B6Yuz6rp/ed69z6jmhyN3Yhj3DTtzwNIYZQmx/SF
         jhT5DwBvS3xmxNKPvfei0LpqgbJOmZuKLyUK2wYyCE/Tg1IJjSJ0URjLr+TYYhp768vW
         OGrdSbrtyYfSf/xo+vB+w4pxsweRRJyYX/6uv1dcXSw8p0Wob8DVrGmxbm0/OVwZigJr
         6Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570960; x=1773175760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        b=C8VXxxa2yC0aqf3yELpJ7yl5kK2N/EdR3uAF/kQssDnYCcVF2Qycn3z1baftib7ePQ
         hxh+1XUzVajeREPun9hJuS47PnFZJTorbwyKF5fpV4WHgOPuAncAF7WJlWdlmjHjLcd2
         EHrR0A0SgYlgNKW24vH6Q/oQBlQESqfArWgJWxq1Sy/bIjBleqs5Pv+9D1EUE8tEoyjB
         j3QVZPZvx0vjmXRj6VXLxd0/HKx3c7c9+UdHH8/bmIj2gpel+XQR8ONqZx/ZT5gIuHTS
         Znfged9efk0KYngUSfbgjmdGR6zZ+pByZzNb01Z7jUlMaQ0ubHYqb7z98e0F4qKiXnNx
         bMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU87hwWGeDJtTNFWdoQBFSFrUWYG8EBBUtSKXNnMttF9H7ml+a4yZU11x7hunslCjM2H15A5D48/XCnWiqym63I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cQZLijI30/A/JB3l83O1c409dr93hyeqot42s/UTHPUZa+wi
	HLzAVYo7zo4EDsGWK140PmKYMAwu+sZpvhktkI38+7SVDlpce/xLMHjkcV9Elz0fKhoJ6LfZWuH
	QeKZkEDj+J5mB4z7VojQGxpQnsb3deXU=
X-Gm-Gg: ATEYQzzLQuM9xZGu83ME25APs73haf5Au6CddvEQAWg3xUPxtn/9wuSsV3U2OQdlw0H
	w5oUmzXnOGk9dBY1fy06RVA4TYo+vnqa8qMJXIHroXPY6MWmGEihOQ1O7bNuE/udK3bJ9gJ5q+t
	7vLv6MgGYYgYU9y8XHS3Lhcs6W1jUsYxngRp+H5c5a8vcUK28qVwDoxWV88XQ2UhBC46k9/l6AJ
	wEDVE/6FcEUwpmAOdD0IWyV9DSTj9XTLa3XuvC0WVozjQQuBs1oBUhhMrYDIodArLZxqlqRFZmM
	bNsm0duN1oK6xT6tFSsts5IpBd+tXaM+CWzffJ7HMsWVcFdBsTw9FQj2ZYQTJ5tz015QfGRygN+
	npORq63XS96964AFX32v8KUgC
X-Received: by 2002:a05:7300:231e:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2bde1d4bc79mr3350396eec.5.1772570960234; Tue, 03 Mar 2026
 12:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
 <aaLh2BxSgC9Jl5iS@google.com> <8a27e9ac-2025-4724-a46d-0a7c90894ba7@kernel.org>
 <aaVf5gv4XjV6Ddt-@google.com> <f2f3a8a1-3dbf-4ef9-a89a-a6ec20791d1c@kernel.org>
 <aaVnifbdxKhBddQp@google.com> <5f8dcb7f-9e4f-4484-b160-3a9ce541d63c@kernel.org>
 <aaWvtn48X8UizaaN@google.com>
In-Reply-To: <aaWvtn48X8UizaaN@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Mar 2026 21:49:06 +0100
X-Gm-Features: AaiRm50lUTXkxHRxiLsKpWNGF1HIgeoo2SkrDpQfQSxM22wzlSiellk8rvn7q80
Message-ID: <CANiq72nK8P1rUYw=y3fMzWZR3f_mW2v0_LSLWR1i0dQTtOqu2w@mail.gmail.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
To: Alice Ryhl <aliceryhl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> It's not relevant in this patch, but another thing that may be useful is
> to add CLIPPY=3D1 to the make invocation when building normally. This
> causes additional warnings to be checked using a tool called clippy.

Yes, please do use `CLIPPY=3D1` -- the build should be Clippy clean
modulo exceptional cases that may slip through (and soon linux-next
will probably start reporting those warnings too).

Thanks!

Cheers,
Miguel
