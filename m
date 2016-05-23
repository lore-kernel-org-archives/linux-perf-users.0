From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: usability issues with inlining and backtraces
Date: Mon, 23 May 2016 11:11:04 -0300
Message-ID: <20160523141104.GG8897@kernel.org>
References: <3421510.JYGX19gbWH@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58049 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbcEWOLK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 May 2016 10:11:10 -0400
Content-Disposition: inline
In-Reply-To: <3421510.JYGX19gbWH@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, May 23, 2016 at 11:10:00AM +0200, Milian Wolff escreveu:
> Hey all,
>=20
> I've recently encountered some nasty issues with perf which should - =
I hope -=20
> be possible to be fixed.

I've quickly read this, all interesting, but I need some time to digest
it fully, which I don't have right now, I'll get to it as soon as I can=
=2E

The fact that other open source tools do it as you expect is a precious
observation, as we can go look at how they solved problems.

Yeah, agreed that we need getting these tools to be more useful for
userland developers, and to, as much as we can, connect events connecte=
d
to source code.

Hopefully some other people will participate.

- Arnaldo
=20
> First of all, I learned about `perf report -s sym,srcline`, most nota=
bly the=20
> `srcline`, which finally (!) allows me to correlate sample cost direc=
tly to=20
> line numbers, without trying to interpret the often quite convoluted =
output of=20
> `perf annotate`. But, take the following example code:
>=20
> ~~~~~~~~~~~~
> #include <complex>
> #include <cmath>
> #include <random>
> #include <iostream>
>=20
> using namespace std;
>=20
> int main()
> {
>     uniform_real_distribution<double> uniform(-1E5, 1E5);
>     default_random_engine engine;
>     double s =3D 0;
>     for (int i =3D 0; i < 1000000; ++i) {
>         s +=3D norm(complex<double>(uniform(engine), uniform(engine))=
);
>     }
>     cout << s << '\n';
>     return 0;
> }
> ~~~~~~~~~~~~
>=20
> Compile it with
>=20
>     g++ -std=3Dc++11 -g -O2 test.cpp
>=20
> Then profile it with perf:
>=20
>     perf record --call-graph dwarf
>=20
> ########## perf report backtraces in face of inlining
>=20
> Now let us go through the the output of the report with srcline enabl=
ed:
>=20
> ~~~~~~~~~~~~
>     perf report --stdio -s sym,srcline --no-children
>=20
>     21.07%  [.] main                   random.tcc:3332
>             |
>             ---__libc_start_main
>                _start
>     20.30%  [.] main                   random.h:143
>             |
>             ---__libc_start_main
>                _start
> ~~~~~~~~~~~~
>=20
> Here, the cost of inlined functions (random.tcc:3332,random.h:143) is=
=20
> attributed to the main function. This is of course correct, but very =
unhelpful=20
> to me as a programmer. I'm much more interested in the line inside te=
st.cpp=20
> which triggered the call to random.tcc:3332 etc. Is there a way to ge=
t that=20
> data? Note how you can a way better backtrace when using GDB on the s=
ame=20
> binary as above:=20
>=20
> ~~~~~~~~~~~~
>     gdb a.out
>     break random.tcc:3332
>     run
> Breakpoint 1, std::generate_canonical<double, 53ul,=20
> std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 21474836=
47ul> >=20
> (__urng=3D...) at /usr/include/c++/6.1.1/bits/random.tcc:3332
> 3332                  __sum +=3D _RealType(__urng() - __urng.min()) *=
 __tmp;
> (gdb) bt
> #0  std::generate_canonical<double, 53ul,=20
> std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 21474836=
47ul> >=20
> (__urng=3D...) at /usr/include/c++/6.1.1/bits/random.tcc:3332
> #1  std::__detail::_Adaptor<std::linear_congruential_engine<unsigned =
long,=20
> 16807ul, 0ul, 2147483647ul>, double>::operator() (this=3D<optimized o=
ut>)
>     at /usr/include/c++/6.1.1/bits/random.h:185
> #2 =20
> std::uniform_real_distribution<double>::operator()<std::linear_congru=
ential_engine<unsigned=20
> long, 16807ul, 0ul, 2147483647ul> > (this=3D<optimized out>, __p=3D..=
=2E,=20
> __urng=3D...)
>     at /usr/include/c++/6.1.1/bits/random.h:1818
> #3 =20
> std::uniform_real_distribution<double>::operator()<std::linear_congru=
ential_engine<unsigned=20
> long, 16807ul, 0ul, 2147483647ul> > (__urng=3D<synthetic pointer>,=20
> this=3D<synthetic pointer>)
>     at /usr/include/c++/6.1.1/bits/random.h:1809
> #4  main () at test.cpp:14
> ~~~~~~~~~~~~
>=20
> Why is perf (or is it libunwind?) not capable of getting the same bac=
ktrace?
>=20
> ######### srcline in perf report backtraces
>=20
> If we continue with the `perf report` output from the command above, =
we'll
> eventually see:
>=20
> ~~~~~~~~~~~~
>=20
>      4.60%  [.] main                   test.cpp:14
>             |
>             ---__libc_start_main
>                _start
>=20
>      3.63%  [.] __hypot_finite         __hypot_finite+257
>             |
>             ---hypot
>                main
>                __libc_start_main
>                _start
>=20
>      3.25%  [.] hypot                  hypot+55
>             |
>             ---main
>                __libc_start_main
>                _start
>=20
>      3.21%  [.] __hypot_finite         __hypot_finite+152
>             |
>             ---hypot
>                main
>                __libc_start_main
>                _start
>=20
>      2.63%  [.] __hypot_finite         __hypot_finite+66
>             |
>             ---hypot
>                main
> ... continued
> ~~~~~~~~~
>=20
> Here, I have again a few things to note:
>=20
> On one hand, we have the same issue as above, namely inlined function=
s being=20
> attributed directly to the parent function. See how the backtrace sho=
ws main=20
> calling hypot? Look at the source, I'm not calling hypot anywhere - i=
t's=20
> std::norm calling it internally eventually. And GDB does know about t=
hat and=20
> can give me a proper backtrace.
>=20
> But, differently to above, the major gripe I have with this output is=
=20
> exemplified by this part:
>=20
> ~~~~~~~~~
>      3.63%  [.] __hypot_finite         __hypot_finite+257
>             |
>             ---hypot
>                main
>                __libc_start_main
>                _start
> ~~~~~~~~~
>=20
> I added `srcline` to the report, but the backtrace still only contain=
s the=20
> symbol name. I hope, that we can simply honor srcline there as well, =
to at=20
> least print something like this instead:
>=20
> ~~~~~~~~~
>      3.63%  [.] __hypot_finite         __hypot_finite+257
>             |
>             ---hypot
>                main at test.cpp:14 ### <-- srcline here as well pleas=
e?
>                __libc_start_main
>                _start
> ~~~~~~~~~
>=20
> Is there a reason why this was not yet implemented? If not, then I'll=
 prepare=20
> a patch for that, as I hope this to be easy to implement.
>=20
> ########## symbol cost aggregation
>=20
> Once we have that implemented, can we maybe account for the following=
: I told=20
> `perf report` to aggregate by symbol first, then srcline, i.e. `-s=20
> sym,srcline`. But the report seems to aggregate by `srcline`, because=
 I see=20
> some symbols (__hypot_finite) multiple times, for different code poin=
ts. Can=20
> we merge those and start the backtrace then at the different code poi=
nts?=20
> Something like this would be my desirable output:
>=20
> ~~~~~~~~
> # see above for what I actually get, here I'm accumulating manually
> $ perf report --stdio -s sym,srcline --no-children |grep __hypot_fini=
te+ | awk=20
> '{sum+=3D$1}END{print sum}'
> 34.96
> # this is what I would like to get directly
> $ perf report --stdio -s sym,srcline --no-children=20
> ...
> 34.96%  [.] __hypot_finite
>             |
>      3.63%  | __hypot_finite         __hypot_finite+257
>             - ...
>      3.21%  | __hypot_finite         __hypot_finite+152
>             - ...
>      ...
> ~~~~~~~~~
>=20
> What do you think?
>=20
> ####### perf annotate for mere mortals
>=20
> To conclude this already long email, I want to raise the mess that is=
 `perf=20
> annotate`. If I run it on my above data file, I get the following out=
put:
>=20
> ~~~~~~~~~
>   1.23 =E2=94=82       mulsd  0x2f2(%rip),%xmm0        # 400bd0 <_IO_=
stdin_used+0x20>
>   2.47 =E2=94=82       subsd  0x2f2(%rip),%xmm0        # 400bd8 <_IO_=
stdin_used+0x28>
>        =E2=94=82     _ZSt13__complex_absCd():
>        =E2=94=82     #if _GLIBCXX_USE_C99_COMPLEX
>        =E2=94=82       inline float
>        =E2=94=82       __complex_abs(__complex__ float __z) { return=20
> __builtin_cabsf(__z); }
>        =E2=94=82
>        =E2=94=82       inline double
>        =E2=94=82       __complex_abs(__complex__ double __z) { return=
=20
> __builtin_cabs(__z); }
>   1.23 =E2=94=82     =E2=86=92 callq  cabs@plt
>        =E2=94=82     _ZNSt12_Norm_helperILb1EE8_S_do_itIdEET_RKSt7com=
plexIS2_E():
>        =E2=94=82         {
>        =E2=94=82           template<typename _Tp>
>        =E2=94=82             static inline _Tp _S_do_it(const complex=
<_Tp>& __z)
>        =E2=94=82             {
>        =E2=94=82               _Tp __res =3D std::abs(__z);
>        =E2=94=82               return __res * __res;
>        =E2=94=82       mulsd  %xmm0,%xmm0
>        =E2=94=82     main():
>        =E2=94=82         for (int i =3D 0; i < 1000000; ++i) {
>   1.23 =E2=94=82       sub    $0x1,%ebp
>        =E2=94=82             s +=3D norm(complex<double>(uniform(engi=
ne),=20
> uniform(engine)));
>   7.41 =E2=94=82       addsd  0x8(%rsp),%xmm0
>        =E2=94=82       movsd  %xmm0,0x8(%rsp)
>        =E2=94=82     int main()
>        =E2=94=82     {
>        =E2=94=82         uniform_real_distribution<double> uniform(-1=
E5, 1E5);
>        =E2=94=82         default_random_engine engine;
>        =E2=94=82         double s =3D 0;
>        =E2=94=82         for (int i =3D 0; i < 1000000; ++i) {
>        =E2=94=82     =E2=86=93 je     24e
>        =E2=94=82    =20
> _ZNSt8__detail4_ModImLm2147483647ELm16807ELm0ELb1ELb1EE6__calcEm():
>        =E2=94=82           struct _Mod<_Tp, __m, __a, __c, true, __s>
>        =E2=94=82           {
>        =E2=94=82             static _Tp
>        =E2=94=82             __calc(_Tp __x)
>        =E2=94=82             {
>        =E2=94=82               _Tp __res =3D __a * __x + __c;
>        =E2=94=82194:   imul   $0x41a7,%rbx,%rbx
>=20
> ~~~~~~~
>=20
> I personally think this output is extremely hard to interpret. I see =
the value=20
> of the above output when you want to look at the cost of hot computat=
ional=20
> kernels, but for most user space applications the above is pretty muc=
h=20
> useless. Most notably, note that the above shows self cost only and I=
 could=20
> not find a way to trigger inclusive cost visualization. It makes me b=
elieve=20
> that the addition of the complex norms is the most costly operation i=
n my=20
> code. That is not true, the inclusive cost of the random engine as we=
ll as=20
> actually computing the norm is way higher, i.e. I see
>=20
>    1.23 =E2=94=82     =E2=86=92 callq  cabs@plt
>=20
> but from the output of `perf report` above that triggers the calls to=
=20
> `__hypot` which have close to 40% of the cost.
>=20
> As such, I propose a "simplified" `perf annotate` output, which gets =
closer to=20
> what you'll see in other profilers, e.g. VTune or also Microsoft Visu=
al=20
> studio's sampling profilers: Use the source files and annotate those =
with=20
> inclusive cost. Only show the cost of individual binary instructions =
(status=20
> quo) when explicitly asked. I.e. I want the output to look something =
like that=20
> (I made up the actual percentages):
>=20
> ~~~~~~~~~
>         #include <complex>
>         #include <cmath>
>         #include <random>
>         #include <iostream>
>=20
>         using namespace std;
>=20
>         int main()
>         {
> 1%          uniform_real_distribution<double> uniform(-1E5, 1E5);
> 1%          default_random_engine engine;
>             double s =3D 0;
> 1%          for (int i =3D 0; i < 1000000; ++i) {
> 95%            s +=3D norm(complex<double>(uniform(engine), uniform(e=
ngine)));
>             }
> 2%          cout << s << '\n';
>             return 0;
>         }
> ~~~~~~~~~
>=20
> Bonus points if I could then navigate to a source line and dig deeper=
 (i.e.=20
> see the instructions for this line and then jump to a function that i=
s being=20
> called e.g.).
>=20
> Thanks a lot for reading this far. Please note that I really like per=
f, I just=20
> have trouble teaching people using it as many things are really reall=
y hard=20
> and I hope we can work together to make perf much easier to use!
>=20
> Thanks
> --=20
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
