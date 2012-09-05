From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] perf tool: fix trivial memory leak while calling
 system_path()
Date: Wed, 5 Sep 2012 16:49:40 +0300
Message-ID: <20120905134937.GN19591@arwen.pp.htv.fi>
References: <CADu=CFrNXPJV-DiMT0Ruw6jZNhbsqg+uwP6UQnu-xrAVMc7mQg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:33097 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753236Ab2IENyC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Sep 2012 09:54:02 -0400
Received: by lagy9 with SMTP id y9so329699lag.19
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Sep 2012 06:53:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADu=CFrNXPJV-DiMT0Ruw6jZNhbsqg+uwP6UQnu-xrAVMc7mQg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: liang xie <xieliang007@gmail.com>
Cc: acme@ghostprotocols.net, mingo@elte.hu, paulus@samba.org, linux-perf-users@vger.kernel.org, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org


--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 05, 2012 at 09:48:54PM +0800, liang xie wrote:
> A trivial memory leak fix while calling system_path
>=20
> Signed-off-by: Liang Xie <xieliang@xiaomi.com>
> ---
>  tools/perf/util/exec_cmd.c |    6 ++++--
>  tools/perf/util/help.c     |    1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/exec_cmd.c b/tools/perf/util/exec_cmd.c
> index 7adf4ad..790cc95 100644
> --- a/tools/perf/util/exec_cmd.c
> +++ b/tools/perf/util/exec_cmd.c
> @@ -83,8 +83,8 @@ void setup_path(void)
>  {
>  	const char *old_path =3D getenv("PATH");
>  	struct strbuf new_path =3D STRBUF_INIT;
> -
> -	add_path(&new_path, perf_exec_path());
> +	const char *exec_path =3D perf_exec_path();
> +	add_path(&new_path, exec_path);
>  	add_path(&new_path, argv0_path);
>=20
>  	if (old_path)
> @@ -95,6 +95,8 @@ void setup_path(void)
>  	setenv("PATH", new_path.buf, 1);
>=20
>  	strbuf_release(&new_path);
> +	if (exec_path)

free(NULL) is safe, the check isn't needed.

> +		free((void *)exec_path);

this cast doesn't look necessary either.

--=20
balbi

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQR1hxAAoJEIaOsuA1yqREqOgQAJZbhQCoVm8hC29+jgkHyvbn
xsJyCMPRcJE6NjwYt6n7Gu71vn3lRNA7o5LivSlAvwgEdth7q9s6aCa0w5Oe/vwo
Gv28fFvLBu/9Lh/Y4GWO27l3EZgI8Y5hMmtvvT/x8rhczBRjIQkg89/uRz1CWGAl
E8bNxtdZKizRjGiOVemDLZ4+GdmVor17h1M0rZX06MNi1SzVD8WHpd6CetERzuaM
UjdHogm7myEupeyGUOJtlrSIPFD8XibabAWIc37Sn9Sk2lhPpuNRRn19wvlI15um
FWYUlA5oQYNgWTEc3+SuVZr7NjsuVsAmyMrvZ5wHgaaS62x7xw6bxXMlK++mFVLp
tw8tpWXWrVaWotPuBo1CXtB3OprOMxNUm7fJsWgAYIjvT2wj3DfuU6exJDH3ZJf2
i+kAKeVQXPlElEj36E1XB996GRETKOniXYiLCreC/B9IsnrVCPbIW1IMdr+c8KGh
VS0ZQObdeaeguzdVg+Qm00IAL8cjTIPCm/Kkf6VPhcO2eklw54ed7KKPEL3hOC4y
O6MNH/aq4LWNn3APzbfAEZC0LQG2biJhWG/8y/PVmRRw7lDv0+i6n85dgfiMWjHF
6e52tabGNMXmJcdS3emdqdUqCLJJLmiQuyM84q06Eah/y6XPiQ7z7tQEqYlNLG5I
g+fNneHwiFivTs3CdQui
=erEW
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--
