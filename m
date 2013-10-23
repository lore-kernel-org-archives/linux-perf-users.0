From: Hiep Trinh <trinhhiepth@gmail.com>
Subject: Compile linux tool perf for Android
Date: Wed, 23 Oct 2013 09:00:16 +0000 (UTC)
Message-ID: <loom.20131023T104641-256@post.gmane.org>
References: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com> <502C4D77.7010505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56989 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3JWJkF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 05:40:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VYuv4-0006SH-Up
	for linux-perf-users@vger.kernel.org; Wed, 23 Oct 2013 11:40:03 +0200
Received: from ip-address-pool-xxx.fpt.vn ([ip-address-pool-xxx.fpt.vn])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 11:40:02 +0200
Received: from trinhhiepth by ip-address-pool-xxx.fpt.vn with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 11:40:02 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

David Ahern <dsahern <at> gmail.com> writes:

> 
> On 8/13/12 9:00 PM, Koteswararao Nelakurthi wrote:
> > I am trying to cross compile Perf source present in 2.6.35/tools/perf
> > directory for ARM.in ubuntu machine.(x86 is host machine).But i am
> > facing the following compilation error as compiler looks at host
> > specific header files instead of looking at header files present in
> > perf/ directory..Please provide Makefile changes required to compile
> > successfully perf for ARM.{{{
> >
> > perf>make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
> >
> 
> Do you have a sysroot for the cross-compile environment? e.g., for WRL3 
> we use:
> 
> CROSS_COMPILE = i586-wrs-linux-gnu-
> CROSS_SYSROOT = /path/to/cross-compile/sysroot
> 
> make CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH) CC="$(CROSS_COMPILE)gcc 
> --sysroot=$(CROSS_SYSROOT)"
> 
> David
> 
> 



I try to compile perf for Android with Android NDK 
base on the page
http://stuff.mit.edu/afs/sipb/contrib/linux
/tools/perf/Documentation/android.txt
I met issues of CROSS_COMPILE and SYSROOT,
 it does not work and responds errors: 

Android NDK: NDK_TOOLCHAIN is defined to the unsupported value
android-ndk-r9/toolchains/arm-linux-androideabi-4.6
/prebuilt/linux-x86/bin/arm-linux-androideabi-
   
Android NDK: Please use one of the following values:
arm-linux-androideabi-4.6 arm-linux-androideabi-4.8
arm-linux-androideabi-clang3.2 arm-linux-androideabi-clang3.3
mipsel-linux-android-4.6 mipsel-linux-android-4.8
mipsel-linux-android-clang3.2 mipsel-linux-android-clang3.3 x86-4.6 x86-4.8
x86-clang3.2 x86-clang3.3    
build/core/init.mk:555: *** Android NDK: Aborting    .  Stop.

I can't fix this error because I used "arm-linux-androideabi-4.6" value and
it also appear in Android NDK/Toolchains directory

If you have any suggestion about that, please reply on this post or send
email to me. I appreciate your help. Thanks
 
