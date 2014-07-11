From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Re: Interrupt caused by software events
Date: Fri, 11 Jul 2014 11:20:58 -0300
Message-ID: <20140711142058.GA27580@gamayun>
References: <20140709135418.GB5767@krava.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:55871 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbaGKOUW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Jul 2014 10:20:22 -0400
Received: by mail-yh0-f41.google.com with SMTP id z6so433808yhz.28
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2014 07:20:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140709135418.GB5767@krava.redhat.com>
 <alpine.DEB.2.10.1407091002490.26636@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>, Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 10:05:55AM -0400, Vince Weaver wrote:
> Not really sure by what you mean by "real-time", but you can theoreticall=
y=20
> set up the perf_event mmap buffer with a low threshold, and have it=20
> configured to send a signal to your program whenever an event comes in.
> In theory you can get the PEBS-like info out that way.  It's going to hav=
e=20
> fairly high overhead though, especially if you set the sample rate high.

On Wed, Jul 09, 2014 at 03:54:18PM +0200, Jiri Olsa wrote:
> hi,
> you could use perf_event_create_kernel_counter interface,
> check the lockup watchdog in kernel/watchdog.c

Vince and Jiri,

Thank you very much for your replies.

I re-read my email and I'm not sure I was clear, so just in case I
didn't made myself clear, here's a high-level example of what I'm
looking for.

/*******************/
/* Gets called whenever my program generates a cache-miss */
void my_func()
{
    unsigned long addr =3D get_ip_that_generated_event();
    printf("A cache-miss occurred at IP: %x!\n", addr);
}

int main()
{
    struct perf_event_attr pe;
    pe.type =3D PERF_TYPE_HARDWARE.
    pe.config =3D PERF_COUNT_HW_CACHE_MISSES;
    ...
    register_handler(&pe, my_func);
    // code to be monitored
    unregister_handler();
    return 0;
}
/*******************/

Every time an event occurs (a cache-miss in my example), my_func should
get called. The get_ip_that_generated_event() function should return the
Instruction Pointer that generated the event.

My impression is that this could be done with a low overhead (other then
that introduced by what I do in my_func), because=20
"perf record -e cache-misses ./a.out"
can pinpoint with little overhead how many times the event was caused by
each instruction. But maybe I'm just missing something.

Vince:
I'm unsure how to configure the mmap buffer you mentioned, and I
couldn't find any examples online. Could you please point me to some
reference, or maybe provide a little example?

Jiri:
I'm under the impression I'd have to be in a kernel module (or in kernel
mode in general) to use perf_event_create_kernel_counter(). Is that
correct?

Thank you once again,
-Martin

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJTv/LKAAoJEKAgcdgOx8KDqyAP/jq21KawduL5ODfljD5c5d+B
MV4B1OCabcx6sGAzguHvgxHTAn6XIsZXTZxeE6g2EpTNbQDgkHOV514JFUrjphnX
fKQwygI7q877bMFvM0fGJw9paH6hNhbki+v1cT1hMXvdUxUMHwcTlzrPnjLWmO6V
vL52RvzyNKqOeOoxLa9csaRSpL8hBxqOP2aThZPinYdgGZvbqoMI5HGkCR4FkZVa
fP7ooNzDwB3ygkWE9lLzm7flAXCUV4LtiZ5/GubkNN31Ffa7vPpivbC40IG3ixBj
nZvrG2GO4mhyy8cyna2cBvLsJPsHnUML639R3oiFU6wVWui5mm+eROz3AlM/FiJr
Qwgm/7BMgCXm6c0c20n/6H9qSVyb1rKWZHMwj4QcsSbr3EMWN9y1gZA/64ZHoy6V
VhVGZzrYlfWJ1egTBK+lEUAWPvAOVhvoji3O8Dyylrt67rzlLl8xoudTqeEZTyQJ
A+R5myACk1ju/K5bWhu2vYqO5rkgxEFzOo/aHIrBs+5NVFhIdN6Ii7NraJfPdZN6
7YojJGgBCeBv/tbA0SroYUuNKAOPvX+MlNWMTKwR2fivomXulxi7JjUt7CaJ8LUn
iARUX3l1vWeVESxjbbCiQIfCKEN60t3SJOY5qmuEkHd1yA0S9dqBMd1yOsqTaAD2
m1XhbKLme+PX+gZ3YWeQ
=MMVO
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
