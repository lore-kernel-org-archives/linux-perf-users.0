Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215805;
	b=hgVF04MW+BUcDUXpkGKl8Kd6lL415OayCoGYNvMoIeHaeZYizCIPk65wgu7M/1b74Fwt
	 qrDYGzvdonUNcpot9psOWqR1KQpN0aQ1cdl1beH3WKZN7bRm/2c1u1cY31j/WE94soFYD
	 fgS9BCnGOgwiH4ejJG5JeTF0+QtedLhv7ym9K+2sHua5wziQOTUKQRSK3EtT0Ogeb+8VM
	 5j2lA8SORHJ1T0rVJJ5qw+GnRemktmKLBYYgJpBtiUm5MHI+6gS8MK+a/Y192a59JXZA1
	 4A5LEcRXTZDkxLnVjTcaEn1e73DmhdSxypCfwUVYpi8TA1sOysf41TOhirll/M69TFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215805;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QFg6WaXKZiXuoSOEntxs6b0JTEObImC6+g3mSXZ3TBw=;
	b=KiWYzFOGfd3LqeD/1GU5TqT2+AOUFSOVahiE+dE/RAsgdU5SX8HLQm9ZOsz+MC3L68m6
	 4rii6yFbsgDaLsT3MlupBq+iK1WFuwuGbw+Or3fzUZkF6xLnzFb0wqK9WEypoRzqs7IgF
	 L02MLyo8ieuHr3U6NDkRel12vT2D1hOny1wyoexNTSDBnlFxbHrrukkGgRBZ9LaCtk60B
	 UhHiaetMbr5DalUKH2pnfZOdmtqUcVvXqrx1gjNPGJxbqzZnn0vGJm1WmsMMTyAtQtwDe
	 XBajwbkBQqYoUZFIdJx1iniX9nDMUbKNfcUGPXhHRAgF4qg6YG6kbxOZv0pKLgRljHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EAbu/eq7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995860A6F48;
	Mon,  9 Nov 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAbu/eq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B7A1F0089F;
	Mon,  9 Nov 2026 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215804;
	bh=QFg6WaXKZiXuoSOEntxs6b0JTEObImC6+g3mSXZ3TBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EAbu/eq7+tNBCV9OnxL/VxekQkXFWvB5XGGpflCvFikxnOnxkxhKMV7w7oFPmkrOf
	 4Goh2fhaDpaVgB8nDgLZtji0dHYqqNhD2+JwHxCQsvzhHXorE0ip0Cena91HTi8qWa
	 Kf+9d9QnCivA918y9khwr9HNDNumo/3CvFOa3T9sO9lZsiwrm9QjrBIjrFcizQatRF
	 XpU4NvzO2d1QxCDM5U8ZgrYn5pSRjFkXCofQR+IBZ6t8c9tyZq5MfOX1GIzxNgU745
	 pSc+Xu88dUA9gH3VBghEqJRyX7wyoPoo3s1GqVK6bcBWPYLz8AUdmCBgHY5idDh5JA
	 mhmd5wev79yrw==
Date: Mon, 9 Nov 2026 10:16:36 +0100
From: Alejandro Colomar <alx+linux-man@kernel.org>
To: Nick Krichevsky <nick@ollien.com>
Cc: linux-man@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Behavior of wakeup_events being 0 in perf_event_open(2)
Message-ID: <avGNA14jLDjGNw6O@debian>
References: <CAN8n623GU-VbFJF1O7nDWhty-dUeTdo7HwPe31m1xDbU=hQVjA@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hec37lstcxggxvlu"
Content-Disposition: inline
In-Reply-To: <CAN8n623GU-VbFJF1O7nDWhty-dUeTdo7HwPe31m1xDbU=hQVjA@mail.gmail.com>


--hec37lstcxggxvlu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-man@kernel.org>
To: Nick Krichevsky <nick@ollien.com>
Cc: linux-man@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Behavior of wakeup_events being 0 in perf_event_open(2)
Message-ID: <avGNA14jLDjGNw6O@debian>
References: <CAN8n623GU-VbFJF1O7nDWhty-dUeTdo7HwPe31m1xDbU=hQVjA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAN8n623GU-VbFJF1O7nDWhty-dUeTdo7HwPe31m1xDbU=hQVjA@mail.gmail.com>

[CC +=3D linux-perf-users@]

Hi Nick,

> Date: 2026-11-08 21:08:44-0500
> From: Nick Krichevsky <nick@ollien.com>
>
> Hi,
>=20
> I was experimenting with perf_event_open(2) and caught this sentence in t=
he
> man page.
>=20
>     Prior to Linux 3.0, setting wakeup_events to 0 resulted in no overflow
>     notifications; more recent kernels treat 0 the same as 1.
>=20
> I wrote a small test program (below) to test this behavior. On
> kernel 7.1.13-200.fc44.x86_64, my experience seems to contradict the man =
page;
> it seems that when wakeup_events is 0, it actually notifies the file desc=
riptor
> when the ring buffer is half filled (4096 byte size buffer here, (4096 by=
tes /
> 2) / (8 bytes per event) =3D 256 events). Setting this to 1 sends a notif=
ication
> after every event.
>=20
> My (rough) reading of the source code supports this understanding:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/events/ring_buffer.c?id=3D7475ea8b58616b33c04afb976cf0fbaad9dd63fb#n3=
22
>=20
> Is this a stale entry in the man page, or is my understanding of this fac=
ility
> incorrect? If it is indeed stale, perhaps this could read

I don't know; it could be stale, or it could be a misunderstanding of
the author of the text, or it could be that you're misunderstanding it.  :)

The commit that added that text was:

	21977c9d2ac8 (2015-01-21; "perf_event_open.2: Clarify description of overf=
low events")

by Vincent.  I've added him to CC.  Let's see if he or some maintainer
can help clarify what happened.

>   Prior to Linux 3.0, setting wakeup_events to 0 resulted in no overflow
>   notifications; more recent kernels generate notifications based on a de=
fault
>   watermark of half the ring buffer size.

If this is true, we should clarify the exact version in which the
behavior changed.

> Test run of program:
>     $ gcc main.c
>     $ ./a.out 0
>     wakeup_events =3D 0
>     wakeup 1: 257 samples of 8 bytes
>     wakeup 2: 256 samples of 8 bytes
>     wakeup 3: 256 samples of 8 bytes
>     wakeup 4: 256 samples of 8 bytes
>     $ ./a.out 1
>     wakeup_events =3D 1
>     wakeup 1: 1 samples of 8 bytes
>     wakeup 2: 1 samples of 8 bytes
>     wakeup 3: 1 samples of 8 bytes
>     wakeup 4: 1 samples of 8 bytes
>=20
> Program:
>     #define _GNU_SOURCE
>     #include <linux/perf_event.h>
>     #include <poll.h>
>     #include <pthread.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <sys/ioctl.h>
>     #include <sys/mman.h>
>     #include <sys/syscall.h>
>     #include <unistd.h>
>=20
>     #define PAGE_SIZE 4096
>=20
>     static void *workload(void *unused) {
>       for (;;) {
>       }
>=20
>       return unused;
>     }
>=20
>     int main(int argc, char **argv) {
>       unsigned wakeup_events =3D argc > 1 ? atoi(argv[1]) : 0;
>=20
>       pthread_t workload_thread;
>       pthread_create(&workload_thread, NULL, workload, NULL);
>       // Needs glibc >=3D 2.42
>       pid_t workload_tid =3D pthread_gettid_np(workload_thread);
>=20
>       struct perf_event_attr attrs =3D {.size =3D sizeof(attrs)};
>       attrs.type =3D PERF_TYPE_SOFTWARE;
>       attrs.config =3D PERF_COUNT_SW_CPU_CLOCK;
>       attrs.freq =3D 1;
>       attrs.sample_freq =3D 49;
>       attrs.disabled =3D 1;
>       attrs.exclude_kernel =3D 1;
>       attrs.wakeup_events =3D wakeup_events;
>=20
>       int fd =3D syscall(SYS_perf_event_open, &attrs, workload_tid, -1, -=
1, 0);
>       if (fd < 0) {
>         perror("perf_event_open");
>         return 1;
>       }
>=20
>       void *buffer =3D
>           mmap(NULL, PAGE_SIZE * 2, PROT_READ | PROT_WRITE, MAP_SHARED, f=
d, 0);
>       if (buffer =3D=3D MAP_FAILED) {
>         perror("mmap");
>         return 1;
>       }
>=20
>       struct perf_event_mmap_page *meta =3D buffer;
>       char *data =3D (char *)buffer + meta->data_offset;
>=20
>       ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
>       printf("wakeup_events =3D %u\n", wakeup_events);
>=20
>       for (int i =3D 1; i <=3D 4; i++) {
>         struct pollfd poll_fd =3D {.fd =3D fd, .events =3D POLLIN};
>         poll(&poll_fd, 1, -1);
>=20
>         uint64_t head =3D __atomic_load_n(&meta->data_head, __ATOMIC_ACQU=
IRE);
>         uint64_t tail =3D meta->data_tail;
>         int sample_count =3D 0;
>         int sample_size =3D 0;
>=20
>         while (tail < head) {
>           struct perf_event_header *header =3D
>               (struct perf_event_header *)(data + tail % meta->data_size);
>=20
>           if (header->type =3D=3D PERF_RECORD_SAMPLE) {
>             sample_count++;
>             sample_size =3D header->size;
>           }
>=20
>           tail +=3D header->size;
>         }
>         __atomic_store_n(&meta->data_tail, tail, __ATOMIC_RELEASE);
>=20
>         printf(
>           "wakeup %d: %d samples of %d bytes\n",
>           i, sample_count, sample_size
>         );
>       }
>=20
>       return 0;
>     }

Thanks a lot for the program!


Have a lovely day!
Alex

>=20
>=20
>=20
>=20
> -Nick Krichevsky

--=20
<https://www.alejandro-colomar.es>

--hec37lstcxggxvlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrxj20ACgkQ64mZXMKQ
wql95BAAktgdPUnIXXKsLl6a4p4C6LiRhHOB3706kNqLbF8R0nrpC/ql6W056ll6
+AeCet7qJSfuPxWBunqEAbsShW1ZG5AP73B6bwLdB4u+RwRHEWebVhVFGgfa6ebW
6a4tHcCWtXzPh8/MjfN8gHy+qFlXSLWfLeTlDXOhqGcHIG7pwalBoMOJo+1Xs4kb
clIoAvQe5Rl07u0GsUSbG7GmYZIXWhi6Tm1putrR+A4bSrkmW/yje3X03RWRauSJ
IUVhs3O5FDkmlsGaHLzyvLzZQmwyG1E3R6Ie6CdUAuWWYyEqEgnFmlBG03NQgzoa
ePx9u9mhZYX5fPNX6blSpx3gr94jSV4BwSNJcxEU3+qIvtjHMflXgnmL9nYNhbFt
nrdY6oSA1TaoKZL6f1W3e6s1Y7ll51KKfKL7eGmI4DcLNXgbmbSrCYGWF2fT+A1x
BsS02GeIO8lO8/X+NScmfMxzcijda9phSET/0xtNDqQPsrdakpE0tkg7dupdjT/u
hnN37cSpyuDhRLk5EZrPOFo88W500fCG3FVKHWb9lXvL1/zThfZ7JzjVHP9s3DZb
Z9GMAyNdQa7/ghcdACWJ1INW9AWQIV9FFZDIy+qoP+Z90wZmAs9QN5bnrkAKCXss
SDStHIuzivNuBt02PM1/mfSAnHlThXecrBerkLHW3dsoCW020Fk=
=nTnS
-----END PGP SIGNATURE-----

--hec37lstcxggxvlu--
